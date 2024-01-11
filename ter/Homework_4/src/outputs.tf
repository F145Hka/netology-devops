output "nat_ips" {
    value = module.test-vm.external_ip_address
    description = "External IP addresses"
    }