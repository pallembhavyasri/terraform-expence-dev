module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-backend"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  #convert StringList to list in terraform to get the first element, split is the func name 
  #subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0) #this give 2 elements(1a,1b)-->to get first value we use element function
  #we can keep in locals and use it here as well 
  subnet_id = local.private_subnet_ids
  ami = data.aws_ami.ami_info.id 

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-backend"
    }
  )
}


module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-frontend"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
  #convert StringList to list in terraform to get the first element, split is the func name 
  #subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0) #this give 2 elements(1a,1b)-->to get first value we use element function
  #we can keep in locals and use it here as well 
  subnet_id = local.public_subnet_ids
  ami = data.aws_ami.ami_info.id 

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-frontend"
    }
  )
}


module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-ansible"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible_sg_id.value]
  #convert StringList to list in terraform to get the first element, split is the func name 
  #subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0) #this give 2 elements(1a,1b)-->to get first value we use element function
  #we can keep in locals and use it here as well 
  subnet_id = local.public_subnet_ids
  ami = data.aws_ami.ami_info.id 
  user_data = file("expence.sh")
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-ansible"
    }
  )
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "backend"
      type    = "A"
      ttl = 1
      records = [
        module.backend.private_ip
      ]
    },
    {
      name    = "frontend"
      type    = "A"
      ttl = 1
      records = [
        module.frontend.private_ip 
      ]
    },
    {
      name    = "" #bhavya.store
      type    = "A"
      ttl = 1
      records = [
        module.frontend.public_ip
      ]
    }
  ]
}
