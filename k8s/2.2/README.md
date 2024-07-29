# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Цель задания

_В тестовой среде Kubernetes нужно создать PV и продемострировать запись и хранение файлов._  

------

### Чеклист готовности к домашнему заданию

1. _Установленное K8s-решение (например, MicroK8S)._  
  
\+
  
2. _Установленный локальный kubectl._  
  
\+

3. _Редактор YAML-файлов с подключенным GitHub-репозиторием._  
  
\+


------

### Дополнительные материалы для выполнения задания

1. _[Инструкция по установке NFS в MicroK8S](https://microk8s.io/docs/nfs)._  
2. _[Описание Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)._  
3. _[Описание динамического провижининга](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/)._  
4. _[Описание Multitool](https://github.com/wbitt/Network-MultiTool)._  

------

### Задание 1

**Что нужно сделать**

_Создать Deployment приложения, использующего локальный PV, созданный вручную._  

1. _Создать Deployment приложения, состоящего из контейнеров busybox и multitool._  
  
Деплоим pv иначе pod не сможет создаться.

```
❯ kubectl apply -f pv.yaml
persistentvolume/pv1 created
  
❯ kubectl get pv
NAME                            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM
                      STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
data-nfs-server-provisioner-0   1Gi        RWO            Retain           Bound       nfs-server-provisioner/data-nfs-server-provisioner-0                   <unset>                          127m
pv1                             512Mi      RWO            Retain           Available
                      local-storage   <unset>                          13s
```
  
Деплоим pvc.

```
❯ kubectl apply -f pvc.yaml
persistentvolumeclaim/pvc-vol created
  
❯ kubectl get persistentvolumeclaims -n netology
NAME      STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    VOLUMEATTRIBUTESCLASS   AGE
pvc-vol   Bound    pv1      512Mi      RWO            local-storage   <unset>                 17s
```
  
Теперь деплоим наш pod.

```
❯ kubectl apply -f deployment.yaml
deployment.apps/volume created

❯ kubectl get po -n netology
NAME                      READY   STATUS    RESTARTS   AGE
volume-75b7f4b84d-pwfzx   2/2     Running   0          18s
```
  
2. _Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде._  
  
\+

3. _Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории._  
  
```
❯ kubectl exec -it -n netology pods/volume-75b7f4b84d-pwfzx -c multitool -- bash

volume-75b7f4b84d-pwfzx:/# cat /test/test.txt
Mon Jul 29 16:29:19 UTC 2024
Mon Jul 29 16:29:24 UTC 2024
Mon Jul 29 16:29:29 UTC 2024
Mon Jul 29 16:29:34 UTC 2024
Mon Jul 29 16:29:39 UTC 2024
Mon Jul 29 16:29:44 UTC 2024
Mon Jul 29 16:29:49 UTC 2024
Mon Jul 29 16:29:54 UTC 2024
Mon Jul 29 16:29:59 UTC 2024
Mon Jul 29 16:30:04 UTC 2024
Mon Jul 29 16:30:09 UTC 2024
Mon Jul 29 16:30:14 UTC 2024
Mon Jul 29 16:30:19 UTC 2024
Mon Jul 29 16:30:24 UTC 2024
Mon Jul 29 16:30:29 UTC 2024
Mon Jul 29 16:30:34 UTC 2024
Mon Jul 29 16:30:39 UTC 2024
Mon Jul 29 16:30:44 UTC 2024
```

4. _Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему._  
  
```
❯ kubectl delete -f deployment.yaml
deployment.apps "volume" deleted

❯ kubectl delete -f pvc.yaml
persistentvolumeclaim "pvc1" deleted

❯ kubectl get pv
NAME                            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                                                  STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
data-nfs-server-provisioner-0   1Gi        RWO            Retain           Bound      nfs-server-provisioner/data-nfs-server-provisioner-0                   <unset>                          148m
pv1                             512Mi      RWO            Retain           Released   netology/pvc1                                          local-storage   <unset>                          9m51s
```
PV находится в состоянии Released, потому что к нему не привязан ни один PVC.

5. _Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV.  Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему._  
  
```
❯ cat /kube-data/test.txt
Mon Jul 29 16:29:19 UTC 2024
Mon Jul 29 16:29:24 UTC 2024
Mon Jul 29 16:29:29 UTC 2024
Mon Jul 29 16:29:34 UTC 2024
Mon Jul 29 16:29:39 UTC 2024
Mon Jul 29 16:29:44 UTC 2024
Mon Jul 29 16:29:49 UTC 2024
Mon Jul 29 16:29:54 UTC 2024
Mon Jul 29 16:29:59 UTC 2024
Mon Jul 29 16:30:04 UTC 2024
Mon Jul 29 16:30:09 UTC 2024
Mon Jul 29 16:30:14 UTC 2024
Mon Jul 29 16:30:19 UTC 2024
Mon Jul 29 16:30:24 UTC 2024
Mon Jul 29 16:30:29 UTC 2024
Mon Jul 29 16:30:34 UTC 2024
Mon Jul 29 16:30:39 UTC 2024
Mon Jul 29 16:30:44 UTC 2024
Mon Jul 29 16:30:49 UTC 2024
Mon Jul 29 16:30:54 UTC 2024
Mon Jul 29 16:30:59 UTC 2024
Mon Jul 29 16:31:04 UTC 2024

❯ kubectl delete -f pv.yaml
persistentvolume "pv1" deleted
```

После удаления PV файл сохранился, так как политика хранения файлов - Retain

5. _Предоставить манифесты, а также скриншоты или вывод необходимых команд._  

[pod-манифест](./deployment.yaml)  
[pv-манифест](./pv.yaml)  
[pvc-манифест](./pvc.yaml)  

------

### Задание 2

**Что нужно сделать**

_Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV._  

1. _Включить и настроить NFS-сервер на MicroK8S._  
  
\+

2. _Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS._  
  
```
❯ kubectl apply -f pvc_nfs.yaml
persistentvolumeclaim/nfs1 created

❯ kubectl get pvc -n netology
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
nfs1   Bound    pvc-184d1ed7-7790-4b81-9795-b79c08d805cb   512Mi      RWX            nfs            <unset>                 10s

❯ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM
                              STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
data-nfs-server-provisioner-0              1Gi        RWO            Retain           Bound    nfs-server-provisioner/data-nfs-server-provisioner-0                  <unset>                          170m
pvc-184d1ed7-7790-4b81-9795-b79c08d805cb   512Mi      RWX            Delete           Bound    netology/nfs1
                              nfs            <unset>                          28s

❯ kubectl apply -f deployment_nfs.yaml
deployment.apps/volume configured

❯ kubectl get po -n netology
NAME                    READY   STATUS    RESTARTS   AGE
volume-cbf7b856-z5l2l   1/1     Running   0          2m22s
```

3. _Продемонстрировать возможность чтения и записи файла изнутри пода._  
  
```
❯ kubectl exec -it -n netology volume-cbf7b856-z5l2l -c multitool -- bash

volume-cbf7b856-z5l2l:/# echo test1 > /test/test.txt

volume-cbf7b856-z5l2l:/# cat /test/test.txt
test1

❯ kubectl exec -it -n nfs-server-provisioner pods/nfs-server-provisioner-0 -- bash

bash-5.0# cat /export/pvc-94793fb0-6e4b-47cf-a8af-8d4645beb865/test.txt
test1
```

4. _Предоставить манифесты, а также скриншоты или вывод необходимых команд._  

  
[pod-манифест](./deployment_nfs.yaml)  
[pvc-манифест](./pvc_nfs.yaml)  

------

### Правила приёма работы

1. _Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  