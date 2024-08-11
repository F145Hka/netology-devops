output "nat_instance_info" {
  value = {
    name        = yandex_compute_instance.nat.name
    ext_ip = yandex_compute_instance.nat.network_interface[0].nat_ip_address
    int_ip = yandex_compute_instance.nat.network_interface[0].ip_address
    network = yandex_vpc_network.netology-vpc.name
    subnet = yandex_vpc_subnet.public.name
  }
}

output "public_vm_info" {
  value = {
    name        = yandex_compute_instance.public.name
    ext_ip = yandex_compute_instance.public.network_interface[0].nat_ip_address
    int_ip = yandex_compute_instance.public.network_interface[0].ip_address
    network = yandex_vpc_network.netology-vpc.name
    subnet = yandex_vpc_subnet.public.name
  }
}

output "private_vm_info" {
  value = {
    name        = yandex_compute_instance.private.name
    ext_ip = yandex_compute_instance.private.network_interface[0].nat_ip_address
    int_ip = yandex_compute_instance.private.network_interface[0].ip_address
    network = yandex_vpc_network.netology-vpc.name
    subnet = yandex_vpc_subnet.private.name
  }
}