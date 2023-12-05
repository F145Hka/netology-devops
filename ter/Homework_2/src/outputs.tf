output "ips" {
    value = {
        web_ip = yandex_compute_instance.web.network_interface[0].nat_ip_address
        db_ip  = yandex_compute_instance.db.network_interface[0].nat_ip_address
    }
}