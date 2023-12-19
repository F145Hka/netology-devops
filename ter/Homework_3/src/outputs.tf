output "vms" {
  value = flatten([
    [for vm in yandex_compute_instance.web_vm : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [for vm in yandex_compute_instance.db_vm : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }],
    [for vm in [yandex_compute_instance.storage_vm] : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }]
  ])
}