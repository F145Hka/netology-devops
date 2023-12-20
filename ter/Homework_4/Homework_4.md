### Задание 1
[Скрин консоли nginx -t](pic/screenshot_7.png)  
### Задание 2
[Скрин консоли](pic/screenshot_8.png) 
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_test-vm"></a> [test-vm](#module\_test-vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | https://cloud.yandex.ru/docs/vpc/operations/subnet-create | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name) | example vm\_db\_ prefix | `string` | `"netology-develop-platform-db"` | no |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name) | example vm\_web\_ prefix | `string` | `"netology-develop-platform-web"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9SJdguFYY5OzL2QV3oG8xzaL+I8DmFNr/Bhl5H+bpcnYqL1b3Jjp3OJ1hcXRXszOUVcHazltwEGbQBgEKMntlTzhKbckYKS1VxMGXC9DRilBr66fS18JGohmfE2MPGPQpt2LUI6WYZY5k+na12B7P3I4vYslyXFF0ZwYUaF1HSxeroKyXbuXvmDQA7mqpp4Ru/Vj4DEjff3NroEBkp/YUQVaSMkg0VCze4gV0PQbaGZjiH5IDxAlyDzQrh1g78q1WjvTJULqrhkEwCabSvReAeBTdPqyRLcdhsa47On5V1vv6jE3u0mW9p3aqoKae6y0c++d8YbcxqJTMNoftCgOTnOTNtf/NidKq9Ld9PpT65GmSR9fiiVzJ+VfUnEvZ+m8Jv+tJhXRUGyMkxmFzQw3F9/hbKWlZ9sMEQHYBdPUfn9S/xuKhU8v6vQ5FcvSsaZO87300ttjdYZ4Zr46XmNJlzbXmTYtzQ2mjSqOttIbKNKdU43WqBl0uASeDqOz30FM= aakutukov@aakutukov-nb"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_ips"></a> [nat\_ips](#output\_nat\_ips) | External IP addresses |  
### Задание 3
Список команд (ID ресурсов посмотрел в web-морде YC)  
`terraform state list` [Скрин](pic/screenshot_9.png)  
`terraform state rm module.vpc` [Скрин](pic/screenshot_10.png)  
`terraform state rm module.test-vm` [Скрин](pic/screenshot_11.png)  
`terraform import module.vpc.yandex_vpc_network.net_name enpiopg8eab3j78stpqc` [Скрин](pic/screenshot_12.png)  
`terraform import module.vpc.yandex_vpc_subnet.subnet_name e9b0i946bh21ojmta1a2` [Скрин](pic/screenshot_13.png)  
`terraform import 'module.test-vm.yandex_compute_instance.vm[0]' fhmeeqdejsv4ulqfdeds` [Скрин](pic/screenshot_14.png)  
`terraform plan` [Скрин](pic/screenshot_15.png)  
