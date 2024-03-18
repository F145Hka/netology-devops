output "vms" {
  value = flatten([
    [for vm in yandex_compute_instance.web_vm : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
      ip   = vm.network_interface[0].nat_ip_address
    }]
  ])
}