variable "disks" {
  type = map
  default = {
    name = "disk"
    type = "network-hdd"
    zone = "ru-central1-a"
    size = 10
  }
}

variable "vm_storage_instance" {
  type = map
  default = {
    "name"        = "storage"
    "platform_id" = "standard-v1"
  }
}

variable "vm_storage_resources" {
    type = map
    default = {
        cores         = 2
        memory        = 1
        core_fraction = 5
    }
}

resource "yandex_compute_disk" "default" {
    name     = "${var.disks.name}-${count.index + 1}"
    type     = var.disks.type
    zone     = var.disks.zone
    size     = var.disks.size

count = 3

}

resource "yandex_compute_instance" "storage_vm" {
    name        = "${var.vm_storage_instance.name}"
    platform_id = var.vm_storage_instance.platform_id
#  allow_stopping_for_update = true
    resources {
        cores         = var.vm_storage_resources["cores"]
        memory        = var.vm_storage_resources["memory"]
        core_fraction = var.vm_storage_resources["core_fraction"]
    }
    boot_disk {
        initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
        }
    }
    scheduling_policy {
        preemptible = true
    }

    dynamic "secondary_disk" {
        for_each = "${yandex_compute_disk.default.*.id}"
        content {
 	        disk_id = yandex_compute_disk.default["${secondary_disk.key}"].id
            auto_delete = true
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = false
    }
    metadata = local.metadata

}