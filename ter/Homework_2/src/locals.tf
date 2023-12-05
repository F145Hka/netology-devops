locals {
  web_name = "netology-${var.vpc_name}-platform-${var.vm_web_instance.name}"
  db_name  = "netology-${var.vpc_name}-platform-${var.vm_db_instance.name}"
  metadata = {
    serial-port-enable = "${var.serial_enabled}"
    ssh_key = "ubuntu:${var.vms_ssh_root_key}"
  }
}