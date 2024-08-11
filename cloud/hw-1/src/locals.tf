locals {
    metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable = "1"
  }
}