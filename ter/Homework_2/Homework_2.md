### Задание 1
1. _Изучите проект. В файле variables.tf объявлены переменные для Yandex provider._  
    +  

2. _Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные: идентификаторы облака, токен доступа. Благодаря .gitignore этот файл не попадёт в публичный репозиторий. Вы можете выбрать иной способ безопасно передать секретные данные в terraform._  
    +  

3. _Сгенерируйте или используйте свой текущий ssh-ключ. Запишите его открытую часть в переменную vms_ssh_root_key._  
    +  

4. _Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть._  
* `platform_id = "standart-v4"`, такой платформы нет.
* Минимальное количество ядер - 2.
    
5. _Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ. Ответ в документации Yandex Cloud._  
`preemptible = true` - Делает машину прерываемой.  
`core_fraction=5` - Выставляет параметр "Гарантированная доля vCPU в 5%"  
Эти параметры помогают нам сэкономить в процессе обучения и развернуть машины с более низкой стоимостью.

[Скрин ЛК Яндекс](screenshot_3.png)  
[Скрин SSH](screenshot_4.png)


### Задание 2
\+  

### Задание 3
\+  

### Задание 4
```
❯ terraform output
ips = {
  "db_ip" = "84.201.175.38"
  "web_ip" = "158.160.49.160"
}
```  
### Задание 5
\+
### Задание 6
\+
### Задание 7
1. _Напишите, какой командой можно отобразить второй элемент списка test_list._  
```
> local.test_list[1]
"staging"
``` 
2. _Найдите длину списка test_list с помощью функции length(<имя переменной>)._  
```
> length(local.test_list)
3
```
3. _Напишите, какой командой можно отобразить значение ключа admin из map test_map._  
```
> local.test_map["admin"]
"John"
```
4. _Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений._  
```
> "${local.test_map["admin"]} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"
```
