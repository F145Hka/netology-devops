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

### Тэги
* Clickhouse
* Vector
* Lighthouse

### Установка необходимых ролей
`ansible-galaxy install -r requirements.yml -p roles`

### Запуск
`ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml`