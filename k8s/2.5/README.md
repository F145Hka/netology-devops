# Домашнее задание к занятию «Helm»

### Цель задания

_В тестовой среде Kubernetes необходимо установить и обновить приложения с помощью Helm._  

------

### Чеклист готовности к домашнему заданию

1. _Установленное k8s-решение, например, MicroK8S._  
2. _Установленный локальный kubectl._  
3. _Установленный локальный Helm._  
4. _Редактор YAML-файлов с подключенным репозиторием GitHub._  

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. _[Инструкция](https://helm.sh/docs/intro/install/) по установке Helm. [Helm completion](https://helm.sh/docs/helm/helm_completion/)._  

------

### Задание 1. Подготовить Helm-чарт для приложения

1. _Необходимо упаковать приложение в чарт для деплоя в разные окружения._  
  
Создаю чарт:
```
❯ helm create multitool
Creating multitool

rm -r multitool/charts
```

2. _Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом._  
  
Редактирую `values.yaml`
```
image:
  repository: wbitt/network-multitool
hosts:
    - host: multitool.local
serviceAccount:
  create: false
```
  
3. _В переменных чарта измените образ приложения для изменения версии._  
  
`tag: "latest"`
  
------
### Задание 2. Запустить две версии в разных неймспейсах

1. _Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения._  
  
```
❯ helm upgrade --install multitool multitool
Release "multitool" has been upgraded. Happy Helming!
NAME: multitool
LAST DEPLOYED: Sun Aug 25 18:12:21 2024
NAMESPACE: default
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=multitool,app.kubernetes.io/instance=multitool" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT

❯ kubectl get po
NAME                         READY   STATUS    RESTARTS   AGE
multitool-6c945cbdb5-76mtm   1/1     Running   0          116s

❯ helm uninstall multitool
release "multitool" uninstalled
```
  
2. _Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2._  
  
```
❯ kubectl create ns app1
namespace/app1 created

❯ kubectl create ns app2
namespace/app2 created

❯ helm upgrade --install multitool multitool --namespace app1
Release "multitool" does not exist. Installing it now.
NAME: multitool
LAST DEPLOYED: Sun Aug 25 18:36:23 2024
NAMESPACE: app1
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=multitool,app.kubernetes.io/instance=multitool" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT

❯ helm upgrade --install multitool-alpine multitool --namespace app1 --set image.tag=alpine-extra
Release "multitool-alpine" does not exist. Installing it now.
NAME: multitool-alpine
LAST DEPLOYED: Sun Aug 25 18:39:03 2024
NAMESPACE: app1
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app1 -l "app.kubernetes.io/name=multitool,app.kubernetes.io/instance=multitool-alpine" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app1 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app1 port-forward $POD_NAME 8080:$CONTAINER_PORT

❯ helm upgrade --install multitool multitool --namespace app2
Release "multitool" does not exist. Installing it now.
NAME: multitool
LAST DEPLOYED: Sun Aug 25 18:37:57 2024
NAMESPACE: app2
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace app2 -l "app.kubernetes.io/name=multitool,app.kubernetes.io/instance=multitool" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace app2 $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace app2 port-forward $POD_NAME 8080:$CONTAINER_PORT
```
  
3. _Продемонстрируйте результат._  
  
```
❯ kubectl get pod -A
NAMESPACE                NAME                                      READY   STATUS    RESTARTS      AGE
app1                     multitool-75f7674bf4-2tbj7                1/1     Running   0             2m58s
app1                     multitool-alpine-84f467c89b-f64wn         1/1     Running   0             63s
app2                     multitool-75f7674bf4-sdkdj                1/1     Running   0             2m9s
ingress                  nginx-ingress-microk8s-controller-wr6qt   1/1     Running   2 (23h ago)   10d
kube-system              calico-kube-controllers-796fb75cc-r86vq   1/1     Running   2 (23h ago)   10d
kube-system              calico-node-2gcvm                         1/1     Running   2 (23h ago)   10d
kube-system              coredns-5986966c54-kxzs5                  1/1     Running   2 (23h ago)   10d
nfs-server-provisioner   nfs-server-provisioner-0                  1/1     Running   2 (23h ago)   10d
```


### Правила приёма работы

1. _Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, `helm`, а также скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  
