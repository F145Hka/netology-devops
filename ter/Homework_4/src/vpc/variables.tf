variable "env_name" {
  type = string
  default = "develop"
}

variable "cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "vpc_name" {
  type = string
  default = "develop"
}