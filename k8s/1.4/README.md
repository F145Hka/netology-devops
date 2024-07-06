# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

### Цель задания

_В тестовой среде Kubernetes необходимо обеспечить доступ к приложению, установленному в предыдущем ДЗ и состоящему из двух контейнеров, по разным портам в разные контейнеры как внутри кластера, так и снаружи._

------

### Чеклист готовности к домашнему заданию
  
1. _Установленное k8s-решение (например, MicroK8S)._ 
   
\+  
  
2. _Установленный локальный kubectl._  
  
\+  
  
3. _Редактор YAML-файлов с подключённым Git-репозиторием._  
  
\+  
  
------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. _[Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов._  
2. _[Описание](https://kubernetes.io/docs/concepts/services-networking/service/) Описание Service._  
3. _[Описание](https://github.com/wbitt/Network-MultiTool) Multitool._  

------

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

1. _Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт._  
```
❯ kubectl apply -n netology -f deployment.yaml
deployment.apps/nginx-multitool created
  
❯ kubectl get po -n netology
NAME                               READY   STATUS              RESTARTS   AGE
nginx-multitool-5d5fb7cc59-6lppw   0/2     ContainerCreating   0          3s
nginx-multitool-5d5fb7cc59-d629d   0/2     ContainerCreating   0          3s
nginx-multitool-5d5fb7cc59-fp54d   0/2     ContainerCreating   0          3s
```
2. _Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080._  
```
❯ kubectl apply -n netology -f service.yaml
service/nginx-multitool-service created
  
❯ kubectl get service -n netology
NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
nginx-multitool-service   ClusterIP   10.152.183.67   <none>        9001/TCP,9002/TCP   5s
```
3. _Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры._  
```
❯ kubectl run testcurl --image praqma/network-multitool --rm -i --tty --namespace netology bash
  
bash-5.1# curl nginx-multitool-service:9002 -I
HTTP/1.1 200 OK
Server: nginx/1.18.0
Date: Sat, 06 Jul 2024 19:31:57 GMT
Content-Type: text/html
Content-Length: 1586
Last-Modified: Sat, 06 Jul 2024 19:20:01 GMT
Connection: keep-alive
ETag: "668998e1-632"
Accept-Ranges: bytes

bash-5.1# curl nginx-multitool-service:9001 -I
HTTP/1.1 200 OK
Server: nginx/1.26.1
Date: Sat, 06 Jul 2024 19:31:59 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 28 May 2024 13:28:07 GMT
Connection: keep-alive
ETag: "6655dbe7-267"
Accept-Ranges: bytes
```
4. _Продемонстрировать доступ с помощью `curl` по доменному имени сервиса._ 
  
Сделано в предыдущем пункте.  
  
5. _Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4._  
  
[deployment-манифест](./deployment.yaml)  
[service-манифест](./service.yaml)  

------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. _Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort._  
  
[service-ex2-манифест](./service-ex2.yaml)
  
2. _Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера._  
```
❯ kubectl apply -n netology -f service-ex2.yaml
service/nginx-multitool-service created
  
❯ kubectl get service -n netology
NAME                      TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
nginx-multitool-service   NodePort   10.152.183.151   <none>        9001:30001/TCP,9002:30002/TCP   42s
  

```
3. _Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2._  
  
Проверяем доступность с локального компьютера.  

```
❯ curl localhost:30001 -I
HTTP/1.1 200 OK
Server: nginx/1.26.1
Date: Sat, 06 Jul 2024 20:01:16 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 28 May 2024 13:28:07 GMT
Connection: keep-alive
ETag: "6655dbe7-267"
Accept-Ranges: bytes

❯ curl localhost:30002 -I
HTTP/1.1 200 OK
Server: nginx/1.18.0
Date: Sat, 06 Jul 2024 20:01:19 GMT
Content-Type: text/html
Content-Length: 1586
Last-Modified: Sat, 06 Jul 2024 19:20:01 GMT
Connection: keep-alive
ETag: "668998e1-632"
Accept-Ranges: byte
```

------

### Правила приёма работы

1. _Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl` и скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  
