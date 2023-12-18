resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
    webservers = yandex_compute_instance.web_vm,
    databases = yandex_compute_instance.db_vm,
    storage = [yandex_compute_instance.storage_vm]
    })

  filename = "${abspath(path.module)}/hosts"
}
