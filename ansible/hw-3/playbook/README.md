## Playbook для установки Clickhouse, Vector Lighthouse

### Требования:
RHEL-подобная ОС (Alma, Rocky, Centos, RedHat) версии >= 7

### Что делает?
* Скачивает дистрибутивы Vector, Clickhouse и Lighthouse
* Устанавливает дистрибутивы Vector, Clickhouse и Lighthouse
* Создает базу Clickhouse
* Создает конфигурационный файл для Vector
* Создает конфигурационный файл для Lighthouse 
* Открывает порт 9000 для Clickhouse
* Устанавливает firewalld, nginx, git

### Параметры
* Создать шаблон конфигурации vector - `templates/vector.yaml.j2`
* Создать шаблон конфигурации lighthouse - `templates/lighthouse.yaml.j2`
* Указать IP-адреса в `prod.yml`
* Указать переменные в файлах `vars.yml`

### Тэги
* Clickhouse
* Vector
* Lighthouse

### Запуск
`ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml`