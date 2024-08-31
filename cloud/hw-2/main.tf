#Networks

resource "yandex_vpc_network" "netology-vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology-vpc.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology-vpc.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.private-route.id
}

resource "yandex_vpc_route_table" "private-route" {
  name       = "private-route"
  network_id = yandex_vpc_network.netology-vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_primary_v4_address
  }
}

resource "yandex_iam_service_account" "sa" {
  name = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-storage-put" {
  folder_id = var.folder_id
  role      = "storage.uploader"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "mystorage" {
  bucket                = "${var.student_name}-${formatdate("YYYYMMDD", timestamp())}"
  access_key            = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.static-key.secret_key
  acl                   = var.acl
}

resource "yandex_storage_object" "image" {
  access_key            = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket = "${var.student_name}-${formatdate("YYYYMMDD", timestamp())}"
  key    = var.image_file_name
  source = var.image_file_path
  depends_on = [yandex_storage_bucket.mystorage]
  acl    = var.acl
}

resource "yandex_resourcemanager_folder_iam_member" "sa-vpc-user" {
  folder_id = var.folder_id
  role      = "vpc.user"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

variable "student_name" {
  type        = string
  default     = "aakutukov"
}

variable "acl" {
  type        = string
  default     = "public-read"
}

resource "yandex_compute_instance_group" "lamp_group" {
  name = var.lamp_name
  service_account_id = yandex_iam_service_account.sa.id
  instance_template {
    platform_id = var.lamp_platform   
    resources {
      memory = var.lamp_memory
      cores  = var.lamp_cores
      core_fraction = var.lamp_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.lamp_disk_image_id
    }
  }
  network_interface {
    subnet_ids = [yandex_vpc_subnet.public.id]
    nat = var.nat
  }  
  scheduling_policy {
    preemptible = var.lamp_scheduling_policy
  }

  metadata = {
      user-data = "${file("/home/aakutukov/projects/netology/netology-devops/cloud/init.yaml")}"
   }
  }
  
  scale_policy {
    fixed_scale {
      size = var.lamp_size
    }
  }

  deploy_policy {
    max_unavailable = var.lamp_max_unavailable
    max_expansion   = var.lamp_max_expansion
  }

  health_check {
    interval = var.lamp_interval
    timeout  = var.lamp_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    tcp_options {
      port = var.lamp_port
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  load_balancer {
        target_group_name = "lamp-group"
  }
}

# resource "yandex_lb_network_load_balancer" "balancer" {
#   name        = var.balancer_name
#   folder_id   = var.folder_id
#   listener {
#     name = var.balancer_listener_name
#     port = var.balancer_listener_port
#     external_address_spec {
#       ip_version = "ipv4"
#     }
#   }
# attached_target_group {
#     target_group_id = yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id
#     healthcheck {
#       name = var.balancer_listener_name
#       interval = var.balancer_interval
#       timeout = var.balancer_timeout
#       unhealthy_threshold = var.unhealthy_threshold
#       healthy_threshold = var.healthy_threshold
#       http_options {
#         port = var.balancer_listener_port
#         path = "/"
#       }
#     }
#   }
# }

# #Public

# variable "yandex_compute_instance_public" {
#   type        = list(object({
#     vm_name = string
#     cores = number
#     memory = number
#     core_fraction = number
#     hostname = string
#     platform_id = string
#   }))

#   default = [{
#       vm_name = "public"
#       cores         = 2
#       memory        = 2
#       core_fraction = 5
#       hostname = "public"
#       platform_id = "standard-v1"
#     }]
# }

# variable "boot_disk_public" {
#   type        = list(object({
#     size = number
#     type = string
#     image_id = string
#     }))
#     default = [ {
#     size = 10
#     type = "network-hdd"
#     image_id = "fd89aken7ea5dq223o7t"
#   }]
# }

# resource "yandex_compute_instance" "public" {
#   name        = var.yandex_compute_instance_public[0].vm_name
#   platform_id = var.yandex_compute_instance_public[0].platform_id
#   hostname = var.yandex_compute_instance_public[0].hostname

#   resources {
#     cores         = var.yandex_compute_instance_public[0].cores
#     memory        = var.yandex_compute_instance_public[0].memory
#     core_fraction = var.yandex_compute_instance_public[0].core_fraction
#   }

#   boot_disk {
#     initialize_params {
#       image_id = var.boot_disk_public[0].image_id
#       type     = var.boot_disk_public[0].type
#       size     = var.boot_disk_public[0].size
#     }
#   }

#   metadata = local.metadata

#   network_interface {
#     subnet_id  = yandex_vpc_subnet.public.id
#     nat        = true
#   }
#   scheduling_policy {
#     preemptible = true
#   }
# }

# #NAT Instance

# variable "yandex_compute_instance_nat" {
#   type        = list(object({
#     vm_name = string
#     cores = number
#     memory = number
#     core_fraction = number
#     hostname = string
#     platform_id = string
#   }))

#   default = [{
#       vm_name = "nat"
#       cores         = 2
#       memory        = 2
#       core_fraction = 5
#       hostname = "nat"
#       platform_id = "standard-v1"
#     }]
# }

# variable "boot_disk_nat" {
#   type        = list(object({
#     size = number
#     type = string
#     image_id = string
#     }))
#     default = [ {
#     size = 10
#     type = "network-hdd"
#     image_id = "fd80mrhj8fl2oe87o4e1"
#   }]
# }

# resource "yandex_compute_instance" "nat" {
#   name        = var.yandex_compute_instance_nat[0].vm_name
#   platform_id = var.yandex_compute_instance_nat[0].platform_id
#   hostname = var.yandex_compute_instance_nat[0].hostname

#   resources {
#     cores         = var.yandex_compute_instance_nat[0].cores
#     memory        = var.yandex_compute_instance_nat[0].memory
#     core_fraction = var.yandex_compute_instance_nat[0].core_fraction
#   }

#   boot_disk {
#     initialize_params {
#       image_id = var.boot_disk_nat[0].image_id
#       type     = var.boot_disk_nat[0].type
#       size     = var.boot_disk_nat[0].size
#     }
#   }

#   metadata = local.metadata

#   network_interface {
#     subnet_id  = yandex_vpc_subnet.public.id
#     nat        = true
#     ip_address = "192.168.10.254"
#   }
#   scheduling_policy {
#     preemptible = true
#   }
# }

#Private

# variable "yandex_compute_instance_private" {
#   type        = list(object({
#     vm_name = string
#     cores = number
#     memory = number
#     core_fraction = number
#     hostname = string
#     platform_id = string
#   }))

#   default = [{
#       vm_name = "private"
#       cores         = 2
#       memory        = 2
#       core_fraction = 5
#       hostname = "private"
#       platform_id = "standard-v1"
#     }]
# }

# variable "boot_disk_private" {
#   type        = list(object({
#     size = number
#     type = string
#     image_id = string
#     }))
#     default = [ {
#     size = 10
#     type = "network-hdd"
#     image_id = "fd89aken7ea5dq223o7t"
#   }]
# }

# resource "yandex_compute_instance" "private" {
#   name        = var.yandex_compute_instance_private[0].vm_name
#   platform_id = var.yandex_compute_instance_private[0].platform_id
#   hostname = var.yandex_compute_instance_private[0].hostname

#   resources {
#     cores         = var.yandex_compute_instance_private[0].cores
#     memory        = var.yandex_compute_instance_private[0].memory
#     core_fraction = var.yandex_compute_instance_private[0].core_fraction
#   }

#   boot_disk {
#     initialize_params {
#       image_id = var.boot_disk_private[0].image_id
#       type     = var.boot_disk_private[0].type
#       size     = var.boot_disk_private[0].size
#     }
#   }

#   metadata = local.metadata

#   network_interface {
#     subnet_id  = yandex_vpc_subnet.private.id
#     nat        = false
#   }
#   scheduling_policy {
#     preemptible = true
#   }
# }