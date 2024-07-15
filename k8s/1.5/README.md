# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 2»

### Цель задания

_В тестовой среде Kubernetes необходимо обеспечить доступ к двум приложениям снаружи кластера по разным путям._  

------

### Чеклист готовности к домашнему заданию

1. _Установленное k8s-решение (например, MicroK8S)._  
2. _Установленный локальный kubectl._  
3. _Редактор YAML-файлов с подключённым Git-репозиторием._  

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. _[Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S._  
2. _[Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Service._  
3. _[Описание](https://kubernetes.io/docs/concepts/services-networking/ingress/) Ingress._  
4. _[Описание](https://github.com/wbitt/Network-MultiTool) Multitool._  

------

### Задание 1. Создать Deployment приложений backend и frontend

1. _Создать Deployment приложения _frontend_ из образа nginx с количеством реплик 3 шт._  
  
\+

2. _Создать Deployment приложения _backend_ из образа multitool._  

```
❯ kubectl get deployments.apps -n netology
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
back    1/1     1            1           127m
front   3/3     3            3           126m
```

3. _Добавить Service, которые обеспечат доступ к обоим приложениям внутри кластера._  
  
```
❯ kubectl get svc -n netology
NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
back-service    ClusterIP   10.152.183.48    <none>        8080/TCP   133m
front-service   ClusterIP   10.152.183.215   <none>        80/TCP     133m
```

4. _Продемонстрировать, что приложения видят друг друга с помощью Service._  
  
```
❯ kubectl exec -n netology back-7687587cf-q4ck4 -- curl front-service:80 -I
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0   615    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 200 OK
Server: nginx/1.26.1
Date: Mon, 15 Jul 2024 19:19:41 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 28 May 2024 13:28:07 GMT
Connection: keep-alive
ETag: "6655dbe7-267"
Accept-Ranges: bytes
```

5. _Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4._  

```
❯ kubectl exec -n netology front-5c66cb74b6-8kbm4 -- curl back-service:8080 -I
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0HTTP/1.1 200 OK
Server: nginx/1.18.0
Date: Mon, 15 Jul 2024 19:09:04 GMT
Content-Type: text/html
Content-Length: 1574
Last-Modified: Mon, 15 Jul 2024 17:17:53 GMT
Connection: keep-alive
ETag: "669559c1-626"
Accept-Ranges: bytes

  0  1574    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
```
  
[deployment-front](./deployment-front.yaml)  
[deployment-back](./deployment-back.yaml)  
[service-front](./service-front.yaml)  
[service-back](./service-back.yaml)


------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. _Включить Ingress-controller в MicroK8S._  

```
❯ microk8s enable ingress
  
❯ kubectl get pods -n ingress
NAME                                      READY   STATUS    RESTARTS   AGE
nginx-ingress-microk8s-controller-nfccc   1/1     Running   0          145m
```

2. _Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера MicroK8S так, чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_._  

```
❯ kubectl get ingresses.networking.k8s.io
NAME            CLASS   HOSTS       ADDRESS   PORTS   AGE
nginx-ingress   nginx   localhost             80      24s
```

3. _Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера._  

```
❯ curl http://localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
  
```
❯ curl http://localhost/api
Praqma Network MultiTool (with NGINX) - back-7687587cf-q4ck4 - 10.1.148.165 - HTTP: 1180 , HTTPS: 443
<br>
<hr>
<br>

<h1>05 Jan 2022 - Press-release: `Praqma/Network-Multitool` is now `wbitt/Network-Multitool`</h1>

<h2>Important note about name/org change:</h2>
<p>
Few years ago, I created this tool with Henrik Høegh, as `praqma/network-multitool`. Praqma was bought by another company, and now the "Praqma" brand is being dismantled. This means the network-multitool's git and docker repositories must go. Since, I was the one maintaining the docker image for all these years, it was decided by the current representatives of the company to hand it over to me so I can continue maintaining it. So, apart from a small change in the repository name, nothing has changed.<br>
</p>
<p>
The existing/old/previous container image `praqma/network-multitool` will continue to work and will remain available for **"some time"** - may be for a couple of months - not sure though.
</p>
<p>
- Kamran Azeem <kamranazeem@gmail.com> <a href=https://github.com/KamranAzeem>https://github.com/KamranAzeem</a>
</p>

<h2>Some important URLs:</h2>

<ul>
  <li>The new official github repository for this tool is: <a href=https://github.com/wbitt/Network-MultiTool>https://github.com/wbitt/Network-MultiTool</a></li>

  <li>The docker repository to pull this image is now: <a href=https://hub.docker.com/r/wbitt/network-multitool>https://hub.docker.com/r/wbitt/network-multitool</a></li>
</ul>

<br>
Or:
<br>

<pre>
  <code>
  docker pull wbitt/network-multitool
  </code>
</pre>


<hr>
```

4. _Предоставить манифесты и скриншоты или вывод команды п.2._  

Демонстрация выше.  
  
[ingress-манифест](./ingress.yaml)
  
------

### Правила приема работы

1. _Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  

------