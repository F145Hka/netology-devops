# Домашнее задание к занятию «Управление доступом»
### Цель задания  
  
_В тестовой среде Kubernetes нужно предоставить ограниченный доступ пользователю._  
  
------
  
### Чеклист готовности к домашнему заданию
1. _Установлено k8s-решение, например MicroK8S._  
2. _Установленный локальный kubectl._  
3. _Редактор YAML-файлов с подключённым github-репозиторием._  
  
------
  
### Инструменты / дополнительные материалы, которые пригодятся для выполнения задания
1. _[Описание](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) RBAC._  
2. _[Пользователи и авторизация RBAC в Kubernetes](https://habr.com/ru/company/flant/blog/470503/)._  
3. _[RBAC with Kubernetes in Minikube](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b)._  
  
------
  
### Задание 1. Создайте конфигурацию для подключения пользователя
1. _Создайте и подпишите SSL-сертификат для подключения к кластеру._  

```
❯ openssl genrsa -out test-user.key 2048

❯ openssl req -new -key test-user.key -out test_user.csr -subj "/CN=test-user/O=netology"

❯ openssl x509 -req -in test_user.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/cert
s/ca.key -CAcreateserial -out test-user.crt -days 365
Certificate request self-signature ok
subject=CN = test-user, O = netology
```

2. _Настройте конфигурационный файл kubectl для подключения._  

```
❯ kubectl config set-credentials test-user --client-certificate=test-user.crt --client-key=test-user.key
User "test-user" set.

❯ kubectl config set-context test-user --cluster=microk8s-cluster --user=test-user
Context "test-user" modified.

❯ kubectl config get-contexts
CURRENT   NAME        CLUSTER            AUTHINFO    NAMESPACE
*         microk8s    microk8s-cluster   admin
          test-user   microk8s-cluster   test-user

```

3. _Создайте роли и все необходимые настройки для пользователя._  

```
❯ kubectl apply -f role.yaml
role.rbac.authorization.k8s.io/pod-view-role created

❯ kubectl apply -f binding.yaml
rolebinding.rbac.authorization.k8s.io/pod-view created

❯ kubectl get role -n netology
NAME            CREATED AT
pod-view-role   2024-08-20T17:00:59Z

❯ kubectl get rolebindings -n netology
NAME       ROLE                 AGE
pod-view   Role/pod-view-role   36s

❯ kubectl apply -f deployment.yaml
deployment.apps/nginx created
```

4. _Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`)._  

```
❯ kubectl config use-context test-user
Switched to context "test-user".

❯ kubectl get po
Error from server (Forbidden): pods is forbidden: User "test-user" cannot list resource "pods" in API group "" in the namespace "default"

❯ kubectl get po -n netology
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7584b6f84c-sns6r   1/1     Running   0          26m

❯ kubectl logs -n netology nginx-7584b6f84c-sns6r
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2024/08/20 17:10:50 [notice] 1#1: using the "epoll" event method
2024/08/20 17:10:50 [notice] 1#1: nginx/1.27.1
2024/08/20 17:10:50 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
2024/08/20 17:10:50 [notice] 1#1: OS: Linux 6.1.0-23-amd64
2024/08/20 17:10:50 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 65536:65536
2024/08/20 17:10:50 [notice] 1#1: start worker processes
2024/08/20 17:10:50 [notice] 1#1: start worker process 29
2024/08/20 17:10:50 [notice] 1#1: start worker process 30

❯ kubectl describe -n netology pod nginx-7584b6f84c-sns6r
Name:             nginx-7584b6f84c-sns6r
Namespace:        netology
Priority:         0
Service Account:  default
Node:             mk8s-1/192.168.233.25
Start Time:       Tue, 20 Aug 2024 20:10:48 +0300
Labels:           app=nginx
                  pod-template-hash=7584b6f84c
Annotations:      cni.projectcalico.org/containerID: d6bffaf42a22dabceab308f2c5e727649d5d4401dc93a504f6adfbfc2b362dce
                  cni.projectcalico.org/podIP: 10.1.186.10/32
                  cni.projectcalico.org/podIPs: 10.1.186.10/32
Status:           Running
IP:               10.1.186.10
IPs:
  IP:           10.1.186.10
Controlled By:  ReplicaSet/nginx-7584b6f84c
Containers:
  nginx:
    Container ID:   containerd://bda83cacd680d584a25fc42817363b0f9a29c93f91cd00040a5022db9a10dfe5
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:447a8665cc1dab95b1ca778e162215839ccbb9189104c79d7ec3a81e14577add
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 20 Aug 2024 20:10:50 +0300
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wtmbg (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-wtmbg:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```

5. _Предоставьте манифесты и скриншоты и/или вывод необходимых команд._  
  
[role](./role.yaml)
[binding](./binding.yaml)
[deployment](./deployment.yaml)
  
------
  
### Правила приёма работы
1. _Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, скриншоты результатов.3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  
  
------