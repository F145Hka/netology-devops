### Задание 1

1. _Возьмите код:_
- _из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),_
- _из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1)._
2. _Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект._
3. _Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей)._

<details>
<summary>tflint</summary>

```
❯ tflint
10 issue(s) found:

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 20:
  20:   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_module_pinned_source.md

Warning: Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)

  on main.tf line 38:
  38: data "template_file" "cloudinit" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] Interpolation-only expressions are deprecated in Terraform v0.12.14 (terraform_deprecated_interpolation)

  on main.tf line 42:
  42:     ssh_public_key     = "${var.vms_ssh_root_key}"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_interpolation.md

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "default_cidr" is declared but not used (terraform_unused_declarations)

  on variables.tf line 22:
  22: variable "default_cidr" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vpc_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 28:
  28: variable "vpc_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_web_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 43:
  43: variable "vm_web_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_db_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 50:
  50: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] Interpolation-only expressions are deprecated in Terraform v0.12.14 (terraform_deprecated_interpolation)

  on vault.tf line 11:
  11:  value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_deprecated_interpolation.md

Warning: Missing version constraint for provider "vault" in `required_providers` (terraform_required_providers)

  on vault.tf line 31:
  31: resource "vault_kv_secret_v2" "test_credentials" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.5.0/docs/rules/terraform_required_providers.md
```

</details>
  
<details>
<summary>checkov</summary>

```
❯ docker run --rm --tty --volume $(pwd):/tf --workdir /tf bridgecrew/checkov --download-external-modules true --directory /tf

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.1.43

terraform scan results:

Passed checks: 1, Failed checks: 3, Skipped checks: 0

Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."
        PASSED for resource: module.test-vm.yandex_compute_instance.vm[0]
        File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73
        Calling File: /main.tf:19-35
Check: CKV_YC_2: "Ensure compute instance does not have public IP."
        FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]
        File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73
        Calling File: /main.tf:19-35

                Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_YC_11: "Ensure security group is assigned to network interface."
        FAILED for resource: module.test-vm.yandex_compute_instance.vm[0]
        File: /.external_modules/github.com/udjin10/yandex_compute_instance/main/main.tf:24-73
        Calling File: /main.tf:19-35

                Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /main.tf:19-35
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision

                19 | module "test-vm" {
                20 |   source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                21 |   env_name        = "develop"
                22 |   network_id      = module.vpc_dev.net_id
                23 |   subnet_zones    = module.vpc_dev.subnet_zone
                24 |   subnet_ids      = module.vpc_dev.subnet_id
                25 |   instance_name   = "web"
                26 |   instance_count  = 1
                27 |   image_family    = "ubuntu-2004-lts"
                28 |   public_ip       = true
                29 |
                30 |   metadata = {
                31 |       user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                32 |       serial-port-enable = 1
                33 |   }
                34 |
                35 | }

secrets scan results:

Passed checks: 0, Failed checks: 2, Skipped checks: 0

Check: CKV_SECRET_6: "Base64 High Entropy String"
        FAILED for resource: 24e7451df05ed5cd4cf1041be67c68f8d89d087a
        File: /vault.tf:4-5
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/secrets-policies/secrets-policy-index/git-secrets-6

                4 |  token = "ed**********"

Check: CKV_SECRET_6: "Base64 High Entropy String"
        FAILED for resource: 89411ac6df79ade26d15ab68868cac39bb165c47
        File: /vault.tf:20-21
        Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/secrets-policies/secrets-policy-index/git-secrets-6

                20 |       password = "myst**********"
```
</details>

  
#### Типы ошибок:  
**tflint:**
- Неиспользуемые переменные.
- Явно не указаны версии провайдеров.
- Использование выражений, которые содержат только интерполяцию - устарело.
- Модуль ссылается на ветку репозитория, а не на конкретный коммит.
  
**checkov:**
- У инстансов есть внешние IP.
- На сетевой интерфес не назначена группа безопасности.
- Модуль ссылается на ветку, а не на конкретный коммит.
- Высокая энтропия строк. (Точно не знаю, что это. Могу предположить, что проблема в явном указании секретов в tf файлах.)
  
------

### Задание 2

1. _Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'._  
\+
2. _Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками Предоставьте скриншоты процесса в качестве ответа._  
[Скрин S3 bucket](pic/screenshot_20.png)  
[Скрин YDB](pic/screenshot_21.png)  
[Скрин YDB](pic/screenshot_22.png)  
[Скрин service account](pic/screenshot_23.png)  
[Скрин S3 ACL](pic/screenshot_24.png)  
[Скрин tfstate в бакете](pic/screenshot_25.png)   

3. _Закоммитьте в ветку 'terraform-05' все изменения._  
\+
4. _Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply._  
\+  
5. _Пришлите ответ об ошибке доступа к state._  
[Скрин ошибки](pic/screenshot_26.png) 
6. _Принудительно разблокируйте state. Пришлите команду и вывод._  
[Скрин разблокировки](pic/screenshot_27.png)  


------
### Задание 3  

1. _Сделайте в GitHub из ветки 'terraform-05' новую ветку 'terraform-hotfix'._  
\+
2. _Проверье код с помощью tflint и checkov, исправьте все предупреждения и ошибки в 'terraform-hotfix', сделайте коммит._  
\+  
3. _Откройте новый pull request 'terraform-hotfix' --> 'terraform-05'._  
\+
4. _Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan._  
\+  
5. _Пришлите ссылку на PR для ревью. Вливать код в 'terraform-05' не нужно._  
\+  

------
### Задание 4

1. Напишите переменные с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 
------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
- type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
```
variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = <проверка>
    }
}
```
------
### Задание 6*

1. Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожьте инфраструктуру тем же способом.


------
### Задание 7*
1. Настройте отдельный terraform root модуль, который будет создавать YDB, s3 bucket для tfstate и сервисный аккаунт с необходимыми правами. 
