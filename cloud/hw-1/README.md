# Домашнее задание к занятию «Организация сети»

### Подготовка к выполнению задания

1. _Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию)._  
2. _Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры._  
3. _Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории._  
4. _Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашнее задание по теме «Облачные провайдеры и синтаксис Terraform». Заранее выберите регион (в случае AWS) и зону._  

---
### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. _Создать пустую VPC. Выбрать зону._  
2. _Публичная подсеть._  

 - _Создать в VPC subnet с названием public, сетью 192.168.10.0/24._  
 - _Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1._  
 - _Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету._  

```
❯ ssh debian@89.169.131.215

debian@public:~$ ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=57 time=5.10 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=57 time=4.47 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=57 time=4.24 ms
^C
--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 4.240/4.604/5.101/0.363 ms
```

3. _Приватная подсеть._  
 - _Создать в VPC subnet с названием private, сетью 192.168.20.0/24._  
 - _Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс._  
 - _Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету._  

```
❯ scp /home/aakutukov/.ssh/id_rsa debian@89.169.131.215:/home/debian/.ssh
id_rsa

debian@public:~$ ssh 192.168.20.29
Linux private 6.1.0-11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.38-4 (2023-08-08) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

debian@private:~$ ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=55 time=5.79 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=55 time=4.72 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=55 time=4.83 ms
64 bytes from 1.1.1.1: icmp_seq=4 ttl=55 time=4.80 ms
^C
--- 1.1.1.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3009ms
rtt min/avg/max/mdev = 4.722/5.032/5.785/0.436 ms
```

Так как задание выполняется в Terraform - ниже команды выполнения в TF.  
Код в [src](./src)

 ```
 ❯ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.126.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

❯ terraform validate
Success! The configuration is valid.

❯ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.nat will be created
  + resource "yandex_compute_instance" "nat" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "nat"
      + id                        = (known after apply)
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "ssh-keys"           = <<-EOT
                debian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzxKc/w7hQ/nQQwE7WYsxyvGM9S37d/iEBC0rAtuOYx0LBmLRD9mbPt1Jh7BX1eEKAGVAh52CbGbLb+FUtOcMa2pIb5GVBvL89KGxlvn6+nVWD7L6OE5q1F2wmd1lSfYByquSqQuVt6GQUPPnWBU9sCCZNZtnmJi/RytsYc81IN7Qz0lAojK1240vnKESE3J/2N6inFU+JLa/MLk04lepHftXCJ3gJF7o8q9kn3JwUGf5dhqlfuwz7OeX/wQ22Kjijp1TmPKHFNbuE2qDnUD1G3ei6T7C1+FPyfW05FRtaPf3CTL148Sg2vu8++broTK9DGd/oY1gqYKVZPTf/cO7yNU+7xayZsYzNoiJTh86sQZDQGPDmdF62tx4VBHU/9c9CV5nJOaS6YhsNPBaMq67dZv6Hgh3KM5U5WImNl+Wii/FSGVny3MlKzh5yE6Jz3ki0aGZ+3u6GAz5t4TRDRxypByVd2siFaa/PSEYbug95nYrcLAyQevRCv8vRLopffck= aakutukov@aakutukov-nb
            EOT
        }
      + name                      = "nat"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd80mrhj8fl2oe87o4e1"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.10.254"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.private will be created
  + resource "yandex_compute_instance" "private" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "private"
      + id                        = (known after apply)
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "ssh-keys"           = <<-EOT
                debian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzxKc/w7hQ/nQQwE7WYsxyvGM9S37d/iEBC0rAtuOYx0LBmLRD9mbPt1Jh7BX1eEKAGVAh52CbGbLb+FUtOcMa2pIb5GVBvL89KGxlvn6+nVWD7L6OE5q1F2wmd1lSfYByquSqQuVt6GQUPPnWBU9sCCZNZtnmJi/RytsYc81IN7Qz0lAojK1240vnKESE3J/2N6inFU+JLa/MLk04lepHftXCJ3gJF7o8q9kn3JwUGf5dhqlfuwz7OeX/wQ22Kjijp1TmPKHFNbuE2qDnUD1G3ei6T7C1+FPyfW05FRtaPf3CTL148Sg2vu8++broTK9DGd/oY1gqYKVZPTf/cO7yNU+7xayZsYzNoiJTh86sQZDQGPDmdF62tx4VBHU/9c9CV5nJOaS6YhsNPBaMq67dZv6Hgh3KM5U5WImNl+Wii/FSGVny3MlKzh5yE6Jz3ki0aGZ+3u6GAz5t4TRDRxypByVd2siFaa/PSEYbug95nYrcLAyQevRCv8vRLopffck= aakutukov@aakutukov-nb
            EOT
        }
      + name                      = "private"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd89aken7ea5dq223o7t"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.public will be created
  + resource "yandex_compute_instance" "public" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "public"
      + id                        = (known after apply)
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "ssh-keys"           = <<-EOT
                debian:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzxKc/w7hQ/nQQwE7WYsxyvGM9S37d/iEBC0rAtuOYx0LBmLRD9mbPt1Jh7BX1eEKAGVAh52CbGbLb+FUtOcMa2pIb5GVBvL89KGxlvn6+nVWD7L6OE5q1F2wmd1lSfYByquSqQuVt6GQUPPnWBU9sCCZNZtnmJi/RytsYc81IN7Qz0lAojK1240vnKESE3J/2N6inFU+JLa/MLk04lepHftXCJ3gJF7o8q9kn3JwUGf5dhqlfuwz7OeX/wQ22Kjijp1TmPKHFNbuE2qDnUD1G3ei6T7C1+FPyfW05FRtaPf3CTL148Sg2vu8++broTK9DGd/oY1gqYKVZPTf/cO7yNU+7xayZsYzNoiJTh86sQZDQGPDmdF62tx4VBHU/9c9CV5nJOaS6YhsNPBaMq67dZv6Hgh3KM5U5WImNl+Wii/FSGVny3MlKzh5yE6Jz3ki0aGZ+3u6GAz5t4TRDRxypByVd2siFaa/PSEYbug95nYrcLAyQevRCv8vRLopffck= aakutukov@aakutukov-nb
            EOT
        }
      + name                      = "public"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd89aken7ea5dq223o7t"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_vpc_network.netology-vpc will be created
  + resource "yandex_vpc_network" "netology-vpc" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "netology-vpc"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_route_table.private-route will be created
  + resource "yandex_vpc_route_table" "private-route" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + labels     = (known after apply)
      + name       = "private-route"
      + network_id = (known after apply)

      + static_route {
          + destination_prefix = "0.0.0.0/0"
          + next_hop_address   = "192.168.10.254"
        }
    }

  # yandex_vpc_subnet.private will be created
  + resource "yandex_vpc_subnet" "private" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "private"
      + network_id     = (known after apply)
      + route_table_id = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.20.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # yandex_vpc_subnet.public will be created
  + resource "yandex_vpc_subnet" "public" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "public"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nat_instance_info = {
      + ext_ip  = (known after apply)
      + int_ip  = "192.168.10.254"
      + name    = "nat"
      + network = "netology-vpc"
      + subnet  = "public"
    }
  + private_vm_info   = {
      + ext_ip  = (known after apply)
      + int_ip  = (known after apply)
      + name    = "private"
      + network = "netology-vpc"
      + subnet  = "private"
    }
  + public_vm_info    = {
      + ext_ip  = (known after apply)
      + int_ip  = (known after apply)
      + name    = "public"
      + network = "netology-vpc"
      + subnet  = "public"
    }
yandex_vpc_network.netology-vpc: Creating...
yandex_vpc_network.netology-vpc: Creation complete after 3s [id=enpj8v7tcsjkglc33h0e]
yandex_vpc_subnet.public: Creating...
yandex_vpc_route_table.private-route: Creating...
yandex_vpc_route_table.private-route: Creation complete after 0s [id=enpq79j24gesbuc3r41o]
yandex_vpc_subnet.private: Creating...
yandex_vpc_subnet.public: Creation complete after 1s [id=e9bsv668pm018tub09to]
yandex_compute_instance.public: Creating...
yandex_compute_instance.nat: Creating...
yandex_vpc_subnet.private: Creation complete after 1s [id=e9bmb9loq0bv2c1g0dus]
yandex_compute_instance.private: Creating...
yandex_compute_instance.public: Still creating... [10s elapsed]
yandex_compute_instance.nat: Still creating... [10s elapsed]
yandex_compute_instance.private: Still creating... [10s elapsed]
yandex_compute_instance.nat: Still creating... [20s elapsed]
yandex_compute_instance.public: Still creating... [20s elapsed]
yandex_compute_instance.private: Still creating... [20s elapsed]
yandex_compute_instance.public: Still creating... [30s elapsed]
yandex_compute_instance.nat: Still creating... [30s elapsed]
yandex_compute_instance.private: Still creating... [30s elapsed]
yandex_compute_instance.public: Creation complete after 34s [id=fhmcnr21qqnpfkfp6diu]
yandex_compute_instance.private: Creation complete after 39s [id=fhms51taamn453ql55b8]
yandex_compute_instance.nat: Still creating... [40s elapsed]
yandex_compute_instance.nat: Still creating... [50s elapsed]
yandex_compute_instance.nat: Still creating... [1m0s elapsed]
yandex_compute_instance.nat: Still creating... [1m10s elapsed]
yandex_compute_instance.nat: Creation complete after 1m12s [id=fhm4pu29apjup0bfb8e8]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

nat_instance_info = {
  "ext_ip" = "51.250.64.231"
  "int_ip" = "192.168.10.254"
  "name" = "nat"
  "network" = "netology-vpc"
  "subnet" = "public"
}
private_vm_info = {
  "ext_ip" = ""
  "int_ip" = "192.168.20.29"
  "name" = "private"
  "network" = "netology-vpc"
  "subnet" = "private"
}
public_vm_info = {
  "ext_ip" = "89.169.131.215"
  "int_ip" = "192.168.10.7"
  "name" = "public"
  "network" = "netology-vpc"
  "subnet" = "public"
}
 ```

_Resource Terraform для Yandex Cloud:_

- _[VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)._  
- _[Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)._  
- _[Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)._  

---
### Задание 2. AWS* (задание со звёздочкой)

_Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе._  

**Что нужно сделать**

1. _Создать пустую VPC с подсетью 10.10.0.0/16._  
2. _Публичная подсеть._  

 - _Создать в VPC subnet с названием public, сетью 10.10.1.0/24._  
 - _Разрешить в этой subnet присвоение public IP по-умолчанию._  
 - _Создать Internet gateway._  
 - _Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway._  
 - _Создать security group с разрешающими правилами на SSH и ICMP. Привязать эту security group на все, создаваемые в этом ДЗ, виртуалки._  
 - _Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться, что есть доступ к интернету._  
 - _Добавить NAT gateway в public subnet._  
3. _Приватная подсеть._  
 - _Создать в VPC subnet с названием private, сетью 10.10.2.0/24._  
 - _Создать отдельную таблицу маршрутизации и привязать её к private подсети._  
 - _Добавить Route, направляющий весь исходящий трафик private сети в NAT._  
 - _Создать виртуалку в приватной сети._  
 - _Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети, и убедиться, что с виртуалки есть выход в интернет._  

_Resource Terraform:_

1. _[VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)._  
1. _[Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)._  
1. _[Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)._  

### Правила приёма работы

_Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
_Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов._  
_Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  