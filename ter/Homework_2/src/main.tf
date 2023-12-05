resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "web" {
  name        = local.web_name
  platform_id = var.vm_web_instance.platform_id
#  allow_stopping_for_update = true
  resources {
    cores         = var.vm_resources.web_resources["cores"]
    memory        = var.vm_resources.web_resources["memory"]
    core_fraction = var.vm_resources.web_resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.metadata

}

resource "yandex_compute_instance" "db" {
  name        = local.db_name
  platform_id = var.vm_db_instance.platform_id
#  allow_stopping_for_update = true
  resources {
    cores         = var.vm_resources.db_resources["cores"]
    memory        = var.vm_resources.db_resources["memory"]
    core_fraction = var.vm_resources.db_resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = local.metadata

}
