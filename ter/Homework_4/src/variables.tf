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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9SJdguFYY5OzL2QV3oG8xzaL+I8DmFNr/Bhl5H+bpcnYqL1b3Jjp3OJ1hcXRXszOUVcHazltwEGbQBgEKMntlTzhKbckYKS1VxMGXC9DRilBr66fS18JGohmfE2MPGPQpt2LUI6WYZY5k+na12B7P3I4vYslyXFF0ZwYUaF1HSxeroKyXbuXvmDQA7mqpp4Ru/Vj4DEjff3NroEBkp/YUQVaSMkg0VCze4gV0PQbaGZjiH5IDxAlyDzQrh1g78q1WjvTJULqrhkEwCabSvReAeBTdPqyRLcdhsa47On5V1vv6jE3u0mW9p3aqoKae6y0c++d8YbcxqJTMNoftCgOTnOTNtf/NidKq9Ld9PpT65GmSR9fiiVzJ+VfUnEvZ+m8Jv+tJhXRUGyMkxmFzQw3F9/hbKWlZ9sMEQHYBdPUfn9S/xuKhU8v6vQ5FcvSsaZO87300ttjdYZ4Zr46XmNJlzbXmTYtzQ2mjSqOttIbKNKdU43WqBl0uASeDqOz30FM= aakutukov@aakutukov-nb"
  description = "ssh-keygen"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}



