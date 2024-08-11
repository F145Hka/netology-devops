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
    next_hop_address   = "192.168.10.254"
  }
}

#Public

variable "yandex_compute_instance_public" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    hostname = string
    platform_id = string
  }))

  default = [{
      vm_name = "public"
      cores         = 2
      memory        = 2
      core_fraction = 5
      hostname = "public"
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_public" {
  type        = list(object({
    size = number
    type = string
    image_id = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
    image_id = "fd89aken7ea5dq223o7t"
  }]
}

resource "yandex_compute_instance" "public" {
  name        = var.yandex_compute_instance_public[0].vm_name
  platform_id = var.yandex_compute_instance_public[0].platform_id
  hostname = var.yandex_compute_instance_public[0].hostname

  resources {
    cores         = var.yandex_compute_instance_public[0].cores
    memory        = var.yandex_compute_instance_public[0].memory
    core_fraction = var.yandex_compute_instance_public[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_public[0].image_id
      type     = var.boot_disk_public[0].type
      size     = var.boot_disk_public[0].size
    }
  }

  metadata = local.metadata

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
  }
  scheduling_policy {
    preemptible = true
  }
}

#NAT Instance

variable "yandex_compute_instance_nat" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    hostname = string
    platform_id = string
  }))

  default = [{
      vm_name = "nat"
      cores         = 2
      memory        = 2
      core_fraction = 5
      hostname = "nat"
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_nat" {
  type        = list(object({
    size = number
    type = string
    image_id = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
    image_id = "fd80mrhj8fl2oe87o4e1"
  }]
}

resource "yandex_compute_instance" "nat" {
  name        = var.yandex_compute_instance_nat[0].vm_name
  platform_id = var.yandex_compute_instance_nat[0].platform_id
  hostname = var.yandex_compute_instance_nat[0].hostname

  resources {
    cores         = var.yandex_compute_instance_nat[0].cores
    memory        = var.yandex_compute_instance_nat[0].memory
    core_fraction = var.yandex_compute_instance_nat[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_nat[0].image_id
      type     = var.boot_disk_nat[0].type
      size     = var.boot_disk_nat[0].size
    }
  }

  metadata = local.metadata

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
    ip_address = "192.168.10.254"
  }
  scheduling_policy {
    preemptible = true
  }
}

#Private

variable "yandex_compute_instance_private" {
  type        = list(object({
    vm_name = string
    cores = number
    memory = number
    core_fraction = number
    hostname = string
    platform_id = string
  }))

  default = [{
      vm_name = "private"
      cores         = 2
      memory        = 2
      core_fraction = 5
      hostname = "private"
      platform_id = "standard-v1"
    }]
}

variable "boot_disk_private" {
  type        = list(object({
    size = number
    type = string
    image_id = string
    }))
    default = [ {
    size = 10
    type = "network-hdd"
    image_id = "fd89aken7ea5dq223o7t"
  }]
}

resource "yandex_compute_instance" "private" {
  name        = var.yandex_compute_instance_private[0].vm_name
  platform_id = var.yandex_compute_instance_private[0].platform_id
  hostname = var.yandex_compute_instance_private[0].hostname

  resources {
    cores         = var.yandex_compute_instance_private[0].cores
    memory        = var.yandex_compute_instance_private[0].memory
    core_fraction = var.yandex_compute_instance_private[0].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_private[0].image_id
      type     = var.boot_disk_private[0].type
      size     = var.boot_disk_private[0].size
    }
  }

  metadata = local.metadata

  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    nat        = false
  }
  scheduling_policy {
    preemptible = true
  }
}