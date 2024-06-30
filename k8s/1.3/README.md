# Домашнее задание к занятию «Запуск приложений в K8S»

### Цель задания

_В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его._

------

### Чеклист готовности к домашнему заданию

1. _Установленное k8s-решение (например, MicroK8S)._  
  
MikroK8S   
  
2. _Установленный локальный kubectl._ 
   
\+  
  
3. _Редактор YAML-файлов с подключённым git-репозиторием._  
  
VSCode  
  

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. _[Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов._
2. _[Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров._
3. _[Описание](https://github.com/wbitt/Network-MultiTool) Multitool._

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. _Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку._  
  
Создаем namespace:  
```
❯ kubectl create namespace netology
namespace/netology created
```
  
Создаем [deployment-манифест](./deployment.yaml) и применяем его:  
```
❯ kubectl apply -n netology -f deployment.yaml
deployment.apps/nginx-multitool created
```
  
Проверяем, что deployment создался:
```
❯ kubectl get deployments.apps -n netology
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
nginx-multitool   1/1     1            1           92s
  
❯ kubectl get -n netology pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-multitool-56c9c9dcb5-rp2qb   2/2     Running   0          113s
```
2. _После запуска увеличить количество реплик работающего приложения до 2._
  
Добавляем реплики. Можно добавить `replicas: 2` в deployment-манифесте и применить его, а можно масштабировать "руками" - `kubectl scale deployment --replicas 2 -n netology nginx-multitool`.
Добавлю в манифест.
Проверяем, что все штатно отработало.
```
❯ kubectl get -n netology deployments.apps
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
nginx-multitool   2/2     2            2           5m43s
  
❯ kubectl get -n netology pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-multitool-56c9c9dcb5-q888j   2/2     Running   0          103s
nginx-multitool-56c9c9dcb5-rp2qb   2/2     Running   0          7m17s
```
  
3. _Продемонстрировать количество подов до и после масштабирования._
  
Сделано выше.  
  
4. _Создать Service, который обеспечит доступ до реплик приложений из п.1._
Создаем [service-манифест](./service.yaml) и применяем его:
```
❯ kubectl apply -n netology -f service.yaml
service/nginx-multitool-service created
  
❯ kubectl get -n netology service
NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)           AGE
nginx-multitool-service   ClusterIP   10.152.183.28   <none>        80/TCP,8080/TCP   20m
```

5. _Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1._
  
Создаем отдельный [манифест](./multitool.yaml) для pod и применяем его:
```
❯ kubectl apply -f multitool.yaml -n netology
pod/multitool created
  
❯ kubectl -n netology get pod
NAME                               READY   STATUS    RESTARTS   AGE
multitool                          1/1     Running   0          11s
nginx-multitool-5d5fb7cc59-bcfwq   2/2     Running   0          23m
nginx-multitool-5d5fb7cc59-fl7d8   2/2     Running   0          23m
```

Проверяем доступность приложений:
```
❯ kubectl exec -n netology multitool -- curl nginx-multitool-service:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615    0     0  15833      0 --:--:-- <!DOCTYPE html>--     0
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
--:--:-- --:--:-- 16184
  
❯ kubectl exec -n netology multitool -- curl nginx-multitool-service:8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1586  100  1586    0     0   997k      0 --:--:-- --:--:-- --:--:-- 1548k
Praqma Network MultiTool (with NGINX) - nginx-multitool-5d5fb7cc59-bcfwq - 10.1.148.186 - HTTP: 1180 , HTTPS: 443
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

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. _Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения._  
  
Создаем отдельный [манифест](./nginx-init.yaml) для init-контейнера и применяем его:
```
❯ kubectl apply -f nginx-init.yaml -n netology
deployment.apps/nginx-init-deployment created
```

2. _Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox._  
```
❯ kubectl get pods -n netology
NAME                                    READY   STATUS     RESTARTS   AGE
multitool                               1/1     Running    0          47m
nginx-init-deployment-b95557d84-4rx67   0/1     Init:0/1   0          2m27s
nginx-multitool-5d5fb7cc59-bcfwq        2/2     Running    0          71m
nginx-multitool-5d5fb7cc59-fl7d8        2/2     Running    0          71m
```
3. _Создать и запустить Service. Убедиться, что Init запустился._  
  
Создаем отдельный [манифест](./nginx-init-service.yaml) для service и применяем его:
```
❯ kubectl apply -f nginx-init-service.yaml -n netology
service/nginx-service created
```

4. _Продемонстрировать состояние пода до и после запуска сервиса._  
  
Состояниие "до" есть выше. Состояние "после":  
```
❯ kubectl get pods -n netology
NAME                                    READY   STATUS    RESTARTS   AGE
multitool                               1/1     Running   0          67m
nginx-init-deployment-b95557d84-4rx67   1/1     Running   0          22m
nginx-multitool-5d5fb7cc59-bcfwq        2/2     Running   0          91m
nginx-multitool-5d5fb7cc59-fl7d8        2/2     Running   0          91m
```

------

### Правила приема работы

1. _Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов._
3. _Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md._

------