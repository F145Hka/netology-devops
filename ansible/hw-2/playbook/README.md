## Playbook для установки Clickhouse и Vector

### Требования:
RHEL-подобная ОС (Alma, Rocky, Centos, RedHat) версии >= 7

### Что делает?
* Скачивает дистрибутивы Vector и Clickhouse
* Устанавливает дистрибутивы Vector и Clickhouse
* Создает базу Clickhouse
* Создает конфигурационный файл для Vector
* Открывает порт 9000 для Clickhouse
* Устанавливает firewalld

### Параметры
* Создать шаблон конфигурации vector - `vector.yaml.j2`
* Указать IP-адреса в `prod.yml`
* Указать устанавливаемые версии и архитектуру пакетов в файлах `vars.yml`

### Тэги
* Clickhouse
* Vector

### Запуск
`ansible-playbook -i inventory/prod.yml site.yml`