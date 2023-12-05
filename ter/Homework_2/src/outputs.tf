output "ips" {
    value = {
        "${local.web_name}" = yandex_compute_instance.web.network_interface[0].nat_ip_address
        "${local.db_name}"  = yandex_compute_instance.db.network_interface[0].nat_ip_address
    }
}