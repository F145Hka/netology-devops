###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology-vpc"
  description = "VPC network"
}

variable "public_subnet" {
  type        = string
  default     = "public"
  description = "subnet name"
}

variable "private_subnet" {
  type        = string
  default     = "private"
  description = "subnet name"
}

variable "image_file_name" {
  type        = string
  default     = "crimea.jpg"
}

variable "image_file_path" {
  type        = string
  default     = "/home/aakutukov/projects/netology/netology-devops/cloud/hw-2/crimea.jpg"
}

variable "sa_name" {
  type        = string
  default     = "aakutukov"
}

variable "lamp_name" {
  type        = string
  default     = "lamp-group"
}
  

variable "lamp_platform" {
  type        = string
  default     = "standard-v1"
}

variable "lamp_memory" {
  type        = number
  default     = 2
}

variable "lamp_cores" {
  type        = number
  default     = 2
}

variable "lamp_core_fraction" {
  description = "guaranteed vCPU: 5, 20, 50 or 100 "
  type        = number
  default     = "20"
}

variable "lamp_disk_image_id" {
  type        = string
  default     = "fd827b91d99psvq5fjit"
}

variable "lamp_scheduling_policy" {
  type        = bool
  default     = "true"
}

variable "lamp_size" {
  type        = number
  default     = 3
}

variable "lamp_max_unavailable" {
  type        = number
  default     = 1
}

variable "lamp_max_expansion" {
  type        = number
  default     = 3
}

variable "lamp_interval" {
  type        = number
  default     = 10
}

variable "lamp_timeout" {
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  type        = number
  default     = 2
}

variable "lamp_port" {
  type        = number
  default     = 80
}

variable "balancer_name" {
  type        = string
  default     = "balancer"
}


variable "balancer_listener_name" {
  type        = string
  default     = "http"
}

variable "balancer_listener_port" {
  type        = number
  default     = 80
}

variable "balancer_interval" {
  type        = number
  default     = 2
}

variable "balancer_timeout" {
  type        = number
  default     = 1
}

variable "nat" {
  type        = bool
  default     = true
}

variable "nat_primary_v4_address" {
  type        = string
  default     = "192.168.10.254"
}

variable "student_name" {
  type        = string
  default     = "aakutukov"
}

variable "acl" {
  type        = string
  default     = "public-read"
}

variable "kms_key_name"  {
  type        = string
  default     = "kms-key"
}

variable "kms_key_description" {
  type        = string
  default     = "symmetric key for object storage"
}

variable "default_algorithm" {
  type        = string
  default     = "AES_128"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  # sensitive   = true
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9SJdguFYY5OzL2QV3oG8xzaL+I8DmFNr/Bhl5H+bpcnYqL1b3Jjp3OJ1hcXRXszOUVcHazltwEGbQBgEKMntlTzhKbckYKS1VxMGXC9DRilBr66fS18JGohmfE2MPGPQpt2LUI6WYZY5k+na12B7P3I4vYslyXFF0ZwYUaF1HSxeroKyXbuXvmDQA7mqpp4Ru/Vj4DEjff3NroEBkp/YUQVaSMkg0VCze4gV0PQbaGZjiH5IDxAlyDzQrh1g78q1WjvTJULqrhkEwCabSvReAeBTdPqyRLcdhsa47On5V1vv6jE3u0mW9p3aqoKae6y0c++d8YbcxqJTMNoftCgOTnOTNtf/NidKq9Ld9PpT65GmSR9fiiVzJ+VfUnEvZ+m8Jv+tJhXRUGyMkxmFzQw3F9/hbKWlZ9sMEQHYBdPUfn9S/xuKhU8v6vQ5FcvSsaZO87300ttjdYZ4Zr46XmNJlzbXmTYtzQ2mjSqOttIbKNKdU43WqBl0uASeDqOz30FM= aakutukov@aakutukov-nb"
  description = "ssh-keygen"
}