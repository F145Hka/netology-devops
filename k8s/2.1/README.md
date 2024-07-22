# Домашнее задание к занятию «Хранение в K8s. Часть 1»

### Цель задания

_В тестовой среде Kubernetes нужно обеспечить обмен файлами между контейнерам пода и доступ к логам ноды._  

------

### Чеклист готовности к домашнему заданию

1. _Установленное K8s-решение (например, MicroK8S)._  
2. _Установленный локальный kubectl._  
3. _Редактор YAML-файлов с подключенным GitHub-репозиторием._  

------

### Дополнительные материалы для выполнения задания

1. _[Инструкция по установке MicroK8S](https://microk8s.io/docs/getting-started)._  
2. _[Описание Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)._  
3. _[Описание Multitool](https://github.com/wbitt/Network-MultiTool)._  

------

### Задание 1 

**Что нужно сделать**

_Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными._  

1. _Создать Deployment приложения, состоящего из контейнеров busybox и multitool._  
  
[deployment-манифест](./deployment.yaml)  
  
`kubectl apply -f deployment.yaml`
  
2. _Сделать так, чтобы busybox писал каждые пять секунд в некий файл в общей директории._  
  
\+  

3. _Обеспечить возможность чтения файла контейнером multitool._  
  
\+

4. _Продемонстрировать, что multitool может читать файл, который периодоически обновляется._  
  
```
❯ kubectl exec -it -n netology pods/volume-f6b56dd75-cmrdf -c multitool -- sh
/ # cat /test/test.txt
Mon Jul 22 15:09:23 UTC 2024
Mon Jul 22 15:09:28 UTC 2024
Mon Jul 22 15:09:33 UTC 2024
Mon Jul 22 15:09:38 UTC 2024
Mon Jul 22 15:09:43 UTC 2024
Mon Jul 22 15:09:48 UTC 2024
Mon Jul 22 15:09:53 UTC 2024
Mon Jul 22 15:09:58 UTC 2024
Mon Jul 22 15:10:03 UTC 2024
Mon Jul 22 15:10:08 UTC 2024
Mon Jul 22 15:10:13 UTC 2024
Mon Jul 22 15:10:18 UTC 2024
Mon Jul 22 15:10:23 UTC 2024
Mon Jul 22 15:10:28 UTC 2024
Mon Jul 22 15:10:33 UTC 2024
Mon Jul 22 15:10:38 UTC 2024
Mon Jul 22 15:10:43 UTC 2024
Mon Jul 22 15:10:48 UTC 2024
Mon Jul 22 15:10:53 UTC 2024
Mon Jul 22 15:10:58 UTC 2024
Mon Jul 22 15:11:03 UTC 2024
Mon Jul 22 15:11:08 UTC 2024
Mon Jul 22 15:11:13 UTC 2024
Mon Jul 22 15:11:18 UTC 2024
Mon Jul 22 15:11:23 UTC 2024
Mon Jul 22 15:11:28 UTC 2024
Mon Jul 22 15:11:33 UTC 2024
```
  
5. _Предоставить манифесты Deployment в решении, а также скриншоты или вывод команды из п. 4._  
  
Сделано выше  

------

### Задание 2

**Что нужно сделать**

_Создать DaemonSet приложения, которое может прочитать логи ноды._  

1. _Создать DaemonSet приложения, состоящего из multitool._  
  
[daemonset-манифест](./daemonset.yaml)  
  
`kubectl apply -f daemonset.yaml`  
  
2. _Обеспечить возможность чтения файла `/var/log/syslog` кластера MicroK8S._  
  
\+
  
3. _Продемонстрировать возможность чтения файла изнутри пода._  
  
```
❯ kubectl exec -it -n netology pods/daemonset-vlkjh -c multitool -- sh
  
/ # tail -f /var/log/syslog
Jul 22 18:24:45 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:45.935419301+03:00" level=info msg="ImageUpdate event &ImageUpdate{Name:docker.io/wbitt/network-multitool@sha256:d1137e87af76ee15cd0b3d4c7e2fcd111ffbd510ccd0af076fc98dddfc50a735,Labels:map[string]string{io.cri-containerd.image: managed,},XXX_unrecognized:[],}"
Jul 22 18:24:45 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:45.936163001+03:00" level=info msg="PullImage \"wbitt/network-multitool:latest\" returns image reference \"sha256:713337546be623588ed8ffd6d5e15dd3ccde8e4555ac5c97e5715d03580d2824\""
Jul 22 18:24:45 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:45.938621901+03:00" level=info msg="CreateContainer within sandbox \"2c8237b20bf3a0dd12217078cc4a48dfa9fdb21b071864e449c03e329e30bb72\" for container &ContainerMetadata{Name:multitool,Attempt:0,}"
Jul 22 18:24:45 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:45.968661803+03:00" level=info msg="CreateContainer within sandbox \"2c8237b20bf3a0dd12217078cc4a48dfa9fdb21b071864e449c03e329e30bb72\" for &ContainerMetadata{Name:multitool,Attempt:0,} returns container id \"1ad7ff4d6d5affa0f2baa0d3e3d20076a3fd58dafd493a1bab129d7a9f1a1264\""
Jul 22 18:24:45 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:45.969245203+03:00" level=info msg="StartContainer for \"1ad7ff4d6d5affa0f2baa0d3e3d20076a3fd58dafd493a1bab129d7a9f1a1264\""
Jul 22 18:24:46 aakutukov-nb microk8s.daemon-containerd[1682867]: time="2024-07-22T18:24:46.010341406+03:00" level=info msg="StartContainer for \"1ad7ff4d6d5affa0f2baa0d3e3d20076a3fd58dafd493a1bab129d7a9f1a1264\" returns successfully"
Jul 22 18:24:46 aakutukov-nb systemd-networkd[111]: calid8f79d4ac6d: Gained IPv6LL
Jul 22 18:24:46 aakutukov-nb microk8s.daemon-kubelite[1683141]: I0722 18:24:46.131165 1683141 pod_startup_latency_tracker.go:102] "Observed pod startup duration" pod="netology/daemonset-pqds4" podStartSLOduration=1.015080303 podStartE2EDuration="2.131115114s" podCreationTimestamp="2024-07-22 18:24:44 +0300 MSK" firstStartedPulling="2024-07-22 18:24:44.82040499 +0300 MSK m=+12924.906283180" lastFinishedPulling="2024-07-22 18:24:45.936439801 +0300 MSK m=+12926.022317991" observedRunningTime="2024-07-22 18:24:46.130975714 +0300 MSK m=+12926.216853904" watchObservedRunningTime="2024-07-22 18:24:46.131115114 +0300 MSK m=+12926.216993404"
Jul 22 18:24:47 aakutukov-nb microk8s.daemon-kubelite[1683141]: E0722 18:24:47.953336 1683141 manager.go:1116] Failed to create existing container: /kubepods/besteffort/podf77f88ff-1cd7-4eb7-a9c9-db89d8aa2266/c188a753ad1b93b1d835aae3a6c77fd565c75f2ab3d48dcc9e52a38e395e9d5e: task c188a753ad1b93b1d835aae3a6c77fd565c75f2ab3d48dcc9e52a38e395e9d5e not found: not found
Jul 22 18:24:47 aakutukov-nb microk8s.daemon-kubelite[1683141]: E0722 18:24:47.955999 1683141 cadvisor_stats_provider.go:501] "Partial failure issuing cadvisor.ContainerInfoV2" err="partial failures: [\"/kubepods/besteffort/podc2ec3346-e456-41e4-a6e3-f5d227dc1b89\": RecentStats: unable to find data in memory cache]"
command terminated with exit code 137
```
  
4. _Предоставить манифесты Deployment, а также скриншоты или вывод команды из п. 2._  
  
Сделано выше.
  
------

### Правила приёма работы

1. _Домашняя работа оформляется в своём Git-репозитории в файле README.md. Выполненное задание пришлите ссылкой на .md-файл в вашем репозитории._  
2. _Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl`, а также скриншоты результатов._  
3. _Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md._  

------