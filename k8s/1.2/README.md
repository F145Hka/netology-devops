# Домашнее задание к занятию «Базовые объекты K8S»

### Цель задания

_В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера._  

------

### Чеклист готовности к домашнему заданию

_1. Установленное k8s-решение (например, MicroK8S)._  
_2. Установленный локальный kubectl._  
_3. Редактор YAML-файлов с подключенным Git-репозиторием._  

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

_1. Описание [Pod](https://kubernetes.io/docs/concepts/workloads/pods/) и примеры манифестов._  
_2. Описание [Service](https://kubernetes.io/docs/concepts/services-networking/service/)._  

------

### Задание 1. Создать Pod с именем hello-world

_1. Создать манифест (yaml-конфигурацию) Pod._  
_2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2._  
_3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере)._  

Создаем конфигурацию Pod: [hello-world-pod.yaml](./hello-world-pod.yaml)  
`kubectl apply -f hello-world-pod.yaml`  
`kubectl port-forward -n default pods/hello-world 8080:8080`  

<details>
<summary>Скрин</summary>

<image src='./images/screenshot_1.png'>

</details>
  
------

### Задание 2. Создать Service и подключить его к Pod

_1. Создать Pod с именем netology-web._  
_2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2._  
_3. Создать Service с именем netology-svc и подключить к netology-web._  
_4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значение (curl или в браузере)._  
  
Создаем конфигурацию Pod: [netology-web.yaml](./netology-web.yaml)  
`kubectl apply -f netology-web.yaml`  
  
Создаем конфигурацию Service: [netology-svc.yaml](./netology-svc.yaml)  
`kubectl apply -f netology-svc.yaml`  
```
❯ kubectl describe service/netology-svc
Name:              netology-svc
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          app=netology-web
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.152.183.219
IPs:               10.152.183.219
Port:              web  8080/TCP
TargetPort:        8080/TCP
Endpoints:         10.1.148.175:8080
Session Affinity:  None
Events:            <none>
```
  
`kubectl port-forward -n default services/netology-svc 8081:8080`

<details>
<summary>Скрин</summary>

<image src='./images/screenshot_2.png'>

</details>


------

### Правила приёма работы

_1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
_2. Файл README.md должен содержать скриншоты вывода команд `kubectl get pods`, а также скриншот результата подключения._  
_3. Репозиторий должен содержать файлы манифестов и ссылки на них в файле README.md._  

------

### Критерии оценки
_Зачёт — выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики._  

_На доработку — задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки._  