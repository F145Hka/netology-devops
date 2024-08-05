# Домашнее задание к занятию «Конфигурация приложений»

### Цель задания

_В тестовой среде Kubernetes необходимо создать конфигурацию и продемонстрировать работу приложения._  

------

### Чеклист готовности к домашнему заданию

1. _Установленное K8s-решение (например, MicroK8s)._  
2. _Установленный локальный kubectl._  
3. _Редактор YAML-файлов с подключённым GitHub-репозиторием._  

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. _[Описание](https://kubernetes.io/docs/concepts/configuration/secret/) Secret._  
2. _[Описание](https://kubernetes.io/docs/concepts/configuration/configmap/) ConfigMap._  
3. _[Описание](https://github.com/wbitt/Network-MultiTool) Multitool._  

------

### Задание 1. Создать Deployment приложения и решить возникшую проблему с помощью ConfigMap. Добавить веб-страницу

1. _Создать Deployment приложения, состоящего из контейнеров nginx и multitool._  
  
\+
  
2. _Решить возникшую проблему с помощью ConfigMap._  
  
Контейнеры не стартуют. Подозреваю, что проблема в портах. Поменяем порт multitool на 1080 с помощью переменной окружения `HTTP_PORT`, но проброшенной через configmap.

3. _Продемонстрировать, что pod стартовал и оба конейнера работают._  
  
```
❯ kubectl get po -n netology
NAME                        READY   STATUS    RESTARTS   AGE
nginx-mt-7bf55d6996-flz8c   2/2     Running   0          93s
```
  
4. _Сделать простую веб-страницу и подключить её к Nginx с помощью ConfigMap. Подключить Service и показать вывод curl или в браузере._  
  
Добавляем в configmap простой HTML. Создаем service и проверяем.

```
❯ kubectl apply -f configmap.yaml
configmap/mt-config configured

❯ kubectl apply -f service.yaml
service/nginx-mt-svc created

❯ kubectl exec -it -n netology nginx-mt-7ccc64cc87-mmhjm -c multitool -- /bin/bash

nginx-mt-7ccc64cc87-mmhjm:/# curl localhost
<html>
  <body>
    <h1>Hello Netology!</h1>
  </body>
</html>
```
  
5. _Предоставить манифесты, а также скриншоты или вывод необходимых команд._  
  
[deployment](./deployment.yaml)  
[configmap](./configmap.yaml)  
[service](./service.yaml)  

------

### Задание 2. Создать приложение с вашей веб-страницей, доступной по HTTPS 

1. _Создать Deployment приложения, состоящего из Nginx._  
  
\+  

2. _Создать собственную веб-страницу и подключить её как ConfigMap к приложению._  
  
\+  

3. _Выпустить самоподписной сертификат SSL. Создать Secret для использования сертификата._  
  
```
❯ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt

❯ kubectl create secret tls nginx-secret --key nginx.key --cert nginx.crt -n netology
secret/nginx-secret created
```

4. _Создать Ingress и необходимый Service, подключить к нему SSL в вид. Продемонстировать доступ к приложению по HTTPS._  
  
```
❯ kubectl apply -f nginx-ingress.yaml
ingress.networking.k8s.io/nginx-ingress created

❯ curl https://localhost -k
<html>
<head><title>503 Service Temporarily Unavailable</title></head>
<body>
<center><h1>503 Service Temporarily Unavailable</h1></center>
<hr><center>nginx</center>
</body>
</html>

❯ kubectl get svc -n netology
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-service   NodePort   10.152.183.22   <none>        80:30683/TCP,443:30166/TCP   8m58s

❯ curl https://localhost:30166
curl: (60) SSL certificate problem: self-signed certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.

❯ curl https://localhost:30166 -k
<html>
  <body>
    <h1>Hello Netology!</h1>
  </body>
</html>
```

Хоть убейте, но я не смог заставить работать ingress на дефолтных портах в WSL. Я перелопатил уже все, что можно, перекурил все форумы.
Я вроде бы все сделал правильно, но на портах 80 и 443 он отказывается работать. Т.е. service работает корректно, а именно ingress нет.
  
4. _Предоставить манифесты, а также скриншоты или вывод необходимых команд._  
  
[nginx-configmap](./nginx-configmap.yaml)
[nginx-deployment](./nginx-deployment.yaml)
[nginx-service](./nginx-service.yaml)
[nginx-ingress](./nginx-ingress.yaml)

------

### Правила приёма работы

1. _Домашняя работа оформляется в своём GitHub-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  

------