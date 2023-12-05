variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type = string
  default     = "ubuntu-2004-lts"
  description = "Image name"
}

variable "vm_web_instance" {
  type = map
  default = {
    "name"        = "web"
    "platform_id" = "standard-v1"
  }
}

variable "vm_db_instance" {
  type = map
  default = {
    "name"        = "db"
    "platform_id" = "standard-v1"
  }
}

variable "vm_resources" {
  type = map
  default = {
    web_resources = {
        cores         = 2
        memory        = 1
        core_fraction = 5
    }
    db_resources = {
        cores         = 2
        memory        = 2
        core_fraction = 20
    }
  }
}

variable "serial_enabled" {
    type = string
    default = 1
    description = "Enables serial on VM"
}
