# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl»

### Цель задания

_Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине или на отдельной виртуальной машине MicroK8S._

------

### Чеклист готовности к домашнему заданию

_1. Личный компьютер с ОС Linux или MacOS_

_или_

_2. ВМ c ОС Linux в облаке либо ВМ на локальной машине для установки MicroK8S_

**Ни то, ни другое. У меня Win 11 + WSL (Ubuntu)**

------

### Инструкция к заданию

_1. Установка MicroK8S:_
_-sudo apt update,_  
_- sudo apt install snapd,_  
_- sudo snap install microk8s --classic,_  
_- добавить локального пользователя в группу `sudo usermod -a -G microk8s $USER`,_  
_- изменить права на папку с конфигурацией `sudo chown -f -R $USER ~/.kube`._  

**\+**
  
_2. Полезные команды:_  
_- проверить статус `microk8s status --wait-ready`;_  
_- подключиться к microK8s и получить информацию можно через команду `microk8s command`, например, `microk8s kubectl get nodes`;_  
_- включить addon можно через команду `microk8s enable`;_  
_- список addon `microk8s status`;_  
_- вывод конфигурации `microk8s config`;_  
_- проброс порта для подключения локально `microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443`._  
  
**ok**  

_3. Настройка внешнего подключения:_  
_- отредактировать файл /var/snap/microk8s/current/certs/csr.conf.template_  
```shell_
# [ alt_names ]
# Add
# IP.4 = 123.45.67.89
```
_- обновить сертификаты `sudo microk8s refresh-certs --cert front-proxy-client.crt`._  
  
\+

_4. Установка kubectl:_  
_- curl -LO https://storage.googleapis.com/kubernetes-release/release/\`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt\`/bin/linux/amd64/kubectl;_  
_- chmod +x ./kubectl;_  
_- sudo mv ./kubectl /usr/local/bin/kubectl;_  
_- настройка автодополнения в текущую сессию `bash source <(kubectl completion bash)`;_  
_- добавление автодополнения в командную оболочку bash `echo "source <(kubectl completion bash)" >> ~/.bashrc`._  

**У меня Zsh, установил автодополнение**

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

_1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S._  
_2. [Инструкция](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/#bash) по установке автодополнения **kubectl**._  
_3. [Шпаргалка](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/) по **kubectl**._  

------

### Задание 1. Установка MicroK8S

_1. Установить MicroK8S на локальную машину или на удалённую виртуальную машину._  
  
Установил в WSL  
  
_2. Установить dashboard._  
  
Установил. С помощью команды `kubectl describe secrets -n kube-system microk8s-dashboard-token` получаем токен.  
  
[Скрин](/images/screenshot_2.png)  
  
_3. Сгенерировать сертификат для подключения к внешнему ip-адресу._  
```
❯ sudo microk8s refresh-certs --cert front-proxy-client.crt
[sudo] password for aakutukov:
Taking a backup of the current certificates under /var/snap/microk8s/6809/certs-backup/
Creating new certificates
Signature ok
subject=CN = front-proxy-client
Getting CA Private Key
Restarting service kubelite.
```

------

### Задание 2. Установка и настройка локального kubectl
_1. Установить на локальную машину kubectl._  
  
Несмотря на то, что WSL как бы локальная ВМ, установил kubectl (который не часть microk8s)  
  
_2. Настроить локально подключение к кластеру._  
  
\+  
    
_3. Подключиться к дашборду с помощью port-forward._  
  
[Скрин_1](/images/screenshot_1.png)  
[Скрин_2](/images/screenshot_2.png)  

------

### Правила приёма работы

_1. Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
_2. Файл README.md должен содержать скриншоты вывода команд `kubectl get nodes` и скриншот дашборда._  

------

### Критерии оценки
_Зачёт — выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики._

_На доработку — задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки._
