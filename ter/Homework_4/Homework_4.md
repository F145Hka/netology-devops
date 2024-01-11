### Задание 1
1. _Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля._  
\+  
2. _Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку._  
\+  
3. _Добавьте в файл cloud-init.yml установку nginx._  
\+  
4. _Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```._  
[Скрин консоли nginx -t](pic/screenshot_7.png)  

---

### Задание 2
1. _Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```._  
\+  
2. _Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks._  
\+  
3. _Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev_  
\+    
4. _Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной._
\+  
5. _Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev._  
[Скрин консоли](pic/screenshot_8.png)   
6. Сгенерируйте документацию к модулю с помощью terraform-docs.
<details>
<summary>Результат работы terraform-docs</summary>

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_test-vm"></a> [test-vm](#module\_test-vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

#### Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | https://cloud.yandex.ru/docs/vpc/operations/subnet-create | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name) | example vm\_db\_ prefix | `string` | `"netology-develop-platform-db"` | no |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name) | example vm\_web\_ prefix | `string` | `"netology-develop-platform-web"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen | `string` | `your ssh key` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | External IP addresses |  

</details>

---

### Задание 3
1. _Выведите список ресурсов в стейте._  
`terraform state list` [Скрин](pic/screenshot_9.png)  
2. _Полностью удалите из стейта модуль vpc._  
`terraform state rm module.vpc` [Скрин](pic/screenshot_10.png)  
3. _Полностью удалите из стейта модуль vm._  
`terraform state rm module.test-vm` [Скрин](pic/screenshot_11.png)  
  
4. _Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно._  
Список команд (ID ресурсов посмотрел в web-морде YC)  
`terraform import module.vpc.yandex_vpc_network.net_name enpiopg8eab3j78stpqc` [Скрин](pic/screenshot_12.png)  
`terraform import module.vpc.yandex_vpc_subnet.subnet_name e9b0i946bh21ojmta1a2` [Скрин](pic/screenshot_13.png)  
`terraform import 'module.test-vm.yandex_compute_instance.vm[0]' fhmeeqdejsv4ulqfdeds` [Скрин](pic/screenshot_14.png)  
`terraform plan` [Скрин](pic/screenshot_15.png) (Тут чтобы совсем не было изменений нужно удалить `allow_stopping_for_update` в модуле **test-vm**, так как этот параметр хранится в state, но не хранится в YC)

---

### Задание 4
1. _Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля._  
  
_Пример вызова_
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

_Предоставьте код, план выполнения, результат из консоли YC._
  
<details> 
  <summary>План выполнения</summary>

```
❯ terraform plan
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=450bbdca2f168b84782fdd4c89551d5922b936ec20e13f52a155b2da507ae22b]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.test-vm.data.yandex_compute_image.my_image: Read complete after 2s [id=fd85an6q1o26nf37i2nl]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.test-vm.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + description               = "TODO: description; {{terraform managed}}"
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "develop-web-0"
      + id                        = (known after apply)
      + labels                    = {
          + "env"     = "develop"
          + "project" = "undefined"
        }
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh_authorized_keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9SJdguFYY5OzL2QV3oG8xzaL+I8DmFNr/Bhl5H+bpcnYqL1b3Jjp3OJ1hcXRXszOUVcHazltwEGbQBgEKMntlTzhKbckYKS1VxMGXC9DRilBr66fS18JGohmfE2MPGPQpt2LUI6WYZY5k+na12B7P3I4vYslyXFF0ZwYUaF1HSxeroKyXbuXvmDQA7mqpp4Ru/Vj4DEjff3NroEBkp/YUQVaSMkg0VCze4gV0PQbaGZjiH5IDxAlyDzQrh1g78q1WjvTJULqrhkEwCabSvReAeBTdPqyRLcdhsa47On5V1vv6jE3u0mW9p3aqoKae6y0c++d8YbcxqJTMNoftCgOTnOTNtf/NidKq9Ld9PpT65GmSR9fiiVzJ+VfUnEvZ+m8Jv+tJhXRUGyMkxmFzQw3F9/hbKWlZ9sMEQHYBdPUfn9S/xuKhU8v6vQ5FcvSsaZO87300ttjdYZ4Zr46XmNJlzbXmTYtzQ2mjSqOttIbKNKdU43WqBl0uASeDqOz30FM= aakutukov@aakutukov-nb
                package_update: true
                package_upgrade: false
                packages:
                 - vim
                 - nginx
            EOT
        }
      + name                      = "develop-web-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd85an6q1o26nf37i2nl"
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
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.vpc_dev.yandex_vpc_network.net_name will be created
  + resource "yandex_vpc_network" "net_name" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "develop"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_dev.yandex_vpc_subnet.subnet_name["ru-central1-a"] will be created
  + resource "yandex_vpc_subnet" "subnet_name" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "develop-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_network.net_name will be created
  + resource "yandex_vpc_network" "net_name" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "production"
      + subnet_ids                = (known after apply)
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet_name["ru-central1-a"] will be created
  + resource "yandex_vpc_subnet" "subnet_name" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet_name["ru-central1-b"] will be created
  + resource "yandex_vpc_subnet" "subnet_name" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-ru-central1-b"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.vpc_prod.yandex_vpc_subnet.subnet_name["ru-central1-c"] will be created
  + resource "yandex_vpc_subnet" "subnet_name" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "production-ru-central1-c"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-c"
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nat_ips = [
      + (known after apply),
    ]
╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on .terraform/modules/test-vm/providers.tf line 2, in provider "template":
│    2:   version = "2.2.0"
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that is
│ now deprecated and will be removed in a future version of Terraform. To silence this warning, move the provider
│ version constraint into the required_providers block.
╵

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```

</details>  
  
[Скрин списка подсетей из YC](pic/screenshot_17.png)

---

### Задание 5
1. _Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети._  
_2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля._  
3. _Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов._  
4. _Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию._  
\-  

---

### Задание 6
1. _Разверните у себя локально vault, используя docker-compose.yml в проекте._  
\+  
2. _Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education"._  
\+  
3. _Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create_  
_Path: example_  
_secret data key: test_  
_secret data value: congrats!_  
\+    
4. _Считайте этот секрет с помощью terraform и выведите его в output по примеру:_  
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
[Скрин output](pic/screenshot_18.png)  
  
5. _Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform._  
  
[Скрин vault с записанным секретом](pic/screenshot_19.png)  

---

### Задние 7
_Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить корневой модуль на два отдельных: создание VPC от создание ВМ в этом vpc._  
\-  