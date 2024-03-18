variable "vm_image" {
  type = string
  default     = "centos-7"
  description = "Image name"
}

variable "vm_instance" {
  type = map
  default = {
    "master"        = "jenkins-master",
    "angent1"       = "jenkins-agent"
  }
}

variable "vm_platform" {
  default = {
    "platform_id" = "standard-v1"
  }
}

variable "vm_resources" {
  type = map
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }
}

data "yandex_compute_image" "centos" {
  family = var.vm_image
}

resource "yandex_compute_instance" "web_vm" {
  for_each = var.vm_instance
  name        = each.value
  platform_id = var.vm_platform.platform_id
#  allow_stopping_for_update = true
  resources {
    cores         = var.vm_resources["cores"]
    memory        = var.vm_resources["memory"]
    core_fraction = var.vm_resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  # count = 2
  metadata = local.metadata

}