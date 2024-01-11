output "net_id" {
  value = yandex_vpc_network.net_name.id
}

output "subnet_id" {
  value = values(yandex_vpc_subnet.subnet_name)[*].id
}

output "subnet_zone" {
  value = values(yandex_vpc_subnet.subnet_name)[*].zone
}