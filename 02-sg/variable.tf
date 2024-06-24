variable "environment"{
    default = "dev"
}

variable "project_name"{
    default = "expence"
}

variable "common_tags"{
    default = {
        Project = "Expence"
        Environment = "Dev"
        Terraform = "true"
    }
}

variable "db_sg_description"{
    default = "SG for DB MYSQL instance"
}

variable "backend_sg_description"{
    default = "SG for backend instance"
}

variable "frontend_sg_description"{
    default = "SG for frontend instance"
}

variable "bastion_sg_description"{
    default = "SG for bastion instance"
}


variable "ansible_sg_description"{
    default = "SG for ansible instance"
}


