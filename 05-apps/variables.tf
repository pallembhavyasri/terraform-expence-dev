variable "project_name" {
  default = "expence"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expence"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "zone_name"{
  default = "bhavya.store"
}

