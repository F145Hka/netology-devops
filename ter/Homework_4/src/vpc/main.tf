resource "yandex_vpc_network" "net_name" {
  name = var.env_name
}

# resource "yandex_vpc_subnet" "subnet_name" {
#   name           = "${var.env_name}-${var.zone}"
#   zone           = var.zone
#   network_id     = yandex_vpc_network.net_name.id
#   v4_cidr_blocks = [var.cidr]
# }

resource "yandex_vpc_subnet" "subnet_name" {
  for_each = {for s in var.subnets: s.zone => s }

  name           = "${var.env_name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.net_name.id
  v4_cidr_blocks = [each.value.cidr]  
}