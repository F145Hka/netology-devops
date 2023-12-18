variable "each_vm" {
  type = list(object(
    {  
        vm_name = string,
        cpu = number,
        ram = number,
        disk = number, 
        core_fraction = number
    }))
    default = [
        {
            vm_name = "main"
            cpu = 4
            ram = 4
            disk = 20
            core_fraction = 5
        },
        {
            vm_name = "replica"
            cpu = 2
            ram = 2
            disk = 10
            core_fraction = 5
        }
    ]
}

resource "yandex_compute_instance" "db_vm" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }
#   for_each = { for key, value in var.each_vm : key => value }
  name = each.value.vm_name
  platform_id = var.vm_instance.platform_id
#  allow_stopping_for_update = true
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  metadata = local.metadata

}
