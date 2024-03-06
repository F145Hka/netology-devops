# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению


1. _Или подготовьте к работе Managed GitLab от yandex cloud [по инструкции](https://cloud.yandex.ru/docs/managed-gitlab/operations/instance/instance-create).
Или создайте виртуальную машину из публичного образа [по инструкции](https://cloud.yandex.ru/marketplace/products/yc/gitlab )._  
  
Создал ВМ в Я.Облаке  

2. _Создайте виртуальную машину и установите на нее gitlab runner, подключите к вашему серверу gitlab  [по инструкции](https://docs.gitlab.com/runner/install/linux-repository.html)._  
  

Так же создал ВМ с gitlab-runner в Я.Облаке  
  
[Скрин](./images/screenshot_1.png)  

3. _(* Необязательное задание повышенной сложности. )  Если вы уже знакомы с k8s попробуйте выполнить задание, запустив gitlab server и gitlab runner в k8s  [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers)._  
  
Не выполнял, так как не знаком с k8s  

4. _Создайте свой новый проект._  
\+  
5. _Создайте новый репозиторий в GitLab, наполните его [файлами](./repository)._  
  
[Скрин](./images/screenshot_4.png)  

6. _Проект должен быть публичным, остальные настройки по желанию._  
\+  

## Основная часть

### DevOps

_В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:_

1. _Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated)._  
\+  
2. _Python версии не ниже 3.7._  
\+  
3. _Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`._  
\+  
4. _Создана директория `/python_api`._  
\+  
5. _Скрипт из репозитория размещён в /python_api._  
\+  
  
6. _Точка вызова: запуск скрипта._  
\+  
  
7. _При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry._  
  
Использую Container Registry в Я.Облаке, так как лень настраивать SSL на ВМ с Gitlab.  
  
[Скрин](./images/screenshot_3.png)  
  
<details><summary>Логи пайплайна</summary>
  
**builder job:**
```
Running with gitlab-runner 16.9.1 (782c6ecb)
  on gr-1 rz3hKWVk, system ID: s_85a60ec39534
Preparing the "shell" executor
00:00
Using Shell (bash) executor...
Preparing environment
00:00
Running on fhmd43tgluuc150oef76...
Getting source from Git repository
00:00
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /home/gitlab-runner/builds/rz3hKWVk/0/root/netology/.git/
Checking out d95e2896 as detached HEAD (ref is main)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
00:02
$ docker build -t my-flask-build:latest .
#0 building with "default" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 571B done
#1 DONE 0.0s
#2 [internal] load metadata for docker.io/library/centos:centos7
#2 DONE 0.9s
#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s
#4 [ 1/10] FROM docker.io/library/centos:centos7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4
#4 DONE 0.0s
#5 [internal] load build context
#5 transferring context: 70B done
#5 DONE 0.1s
#6 [ 4/10] RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && tar xzf Python-3.7.2.tgz
#6 CACHED
#7 [ 5/10] RUN cd Python-3.7.2 && ./configure --enable-optimizations && make altinstall
#7 CACHED
#8 [ 9/10] COPY requirements.txt /python_api/
#8 CACHED
#9 [ 2/10] RUN yum -y --enablerepo=extras install epel-release && yum clean all && yum -y update
#9 CACHED
#10 [ 3/10] RUN yum install wget make gcc openssl-devel bzip2-devel libffi-devel -y
#10 CACHED
#11 [ 6/10] RUN mkdir /python_api
#11 CACHED
#12 [ 7/10] WORKDIR /python_api
#12 CACHED
#13 [ 8/10] COPY python-api.py /python_api/
#13 CACHED
#14 [10/10] RUN pip3.7 install -r requirements.txt
#14 CACHED
#15 exporting to image
#15 exporting layers done
#15 writing image sha256:391fe786508f6502debefa17e02cbb0e469bfa27a557835010caa4a99d744c6a 0.0s done
#15 naming to docker.io/library/my-flask-build:latest 0.0s done
#15 DONE 0.0s
Job succeeded
```
</br>

**deployer job:**
```
Running with gitlab-runner 16.9.1 (782c6ecb)
  on gr-1 rz3hKWVk, system ID: s_85a60ec39534
Preparing the "shell" executor
00:00
Using Shell (bash) executor...
Preparing environment
00:00
Running on fhmd43tgluuc150oef76...
Getting source from Git repository
00:00
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /home/gitlab-runner/builds/rz3hKWVk/0/root/netology/.git/
Checking out d95e2896 as detached HEAD (ref is main)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
00:02
$ docker build -t $YCR_REGISTRY/hello:gitlab-$CI_COMMIT_SHORT_SHA .
#0 building with "default" instance using docker driver
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 571B done
#1 DONE 0.1s
#2 [internal] load metadata for docker.io/library/centos:centos7
#2 DONE 0.2s
#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.1s
#4 [ 1/10] FROM docker.io/library/centos:centos7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4
#4 DONE 0.0s
#5 [internal] load build context
#5 transferring context: 70B done
#5 DONE 0.0s
#6 [ 3/10] RUN yum install wget make gcc openssl-devel bzip2-devel libffi-devel -y
#6 CACHED
#7 [ 2/10] RUN yum -y --enablerepo=extras install epel-release && yum clean all && yum -y update
#7 CACHED
#8 [ 5/10] RUN cd Python-3.7.2 && ./configure --enable-optimizations && make altinstall
#8 CACHED
#9 [ 6/10] RUN mkdir /python_api
#9 CACHED
#10 [ 9/10] COPY requirements.txt /python_api/
#10 CACHED
#11 [ 4/10] RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && tar xzf Python-3.7.2.tgz
#11 CACHED
#12 [ 7/10] WORKDIR /python_api
#12 CACHED
#13 [ 8/10] COPY python-api.py /python_api/
#13 CACHED
#14 [10/10] RUN pip3.7 install -r requirements.txt
#14 CACHED
#15 exporting to image
#15 exporting layers done
#15 writing image sha256:391fe786508f6502debefa17e02cbb0e469bfa27a557835010caa4a99d744c6a 0.0s done
#15 naming to cr.yandex/crpa34hbgsn2rmnok4f7/hello:gitlab-d95e2896 0.0s done
#15 DONE 0.0s
$ docker login -u $YCR_TOKEN_TYPE -p $YCR_TOKEN $YCR_REGISTRY
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
WARNING! Your password will be stored unencrypted in /home/gitlab-runner/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
$ docker push $YCR_REGISTRY/hello:gitlab-$CI_COMMIT_SHORT_SHA
The push refers to repository [cr.yandex/crpa34hbgsn2rmnok4f7/hello]
ff4d8fdc8a01: Preparing
1f19ce7b5431: Preparing
e98239a0404f: Preparing
5f70bf18a086: Preparing
597900e78857: Preparing
c783de0b1043: Preparing
560eea60aaad: Preparing
d106ecf548f5: Preparing
ec7949d866f3: Preparing
174f56854903: Preparing
c783de0b1043: Waiting
560eea60aaad: Waiting
d106ecf548f5: Waiting
ec7949d866f3: Waiting
174f56854903: Waiting
5f70bf18a086: Layer already exists
597900e78857: Layer already exists
ff4d8fdc8a01: Layer already exists
1f19ce7b5431: Layer already exists
e98239a0404f: Layer already exists
c783de0b1043: Layer already exists
560eea60aaad: Layer already exists
d106ecf548f5: Layer already exists
ec7949d866f3: Layer already exists
174f56854903: Layer already exists
gitlab-d95e2896: digest: sha256:a5a795b77d31b725247229301040566bca764baf78f1a71fbe999155be2c9e97 size: 2416
Job succeeded
```

</details>

### Product Owner

_Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:_
  
1. _Какой метод необходимо исправить._  
2. _Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`._  
3. _Issue поставить label: feature._  
  
Создал issue.
[Скрин](./images/screenshot_5.png)  

### Developer

_Пришёл новый Issue на доработку, вам нужно:_

1. _Создать отдельную ветку, связанную с этим Issue._  
\+  
2. _Внести изменения по тексту из задания._  
\+
3. _Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно._  
  
Сделал MR, сборка успешна.  
[Скрин MR](./images/screenshot_6.png)  
Новый образ появился в registry.  
[Скрин CR](./images/screenshot_7.png)  


### Tester

_Разработчики выполнили новый Issue, необходимо проверить валидность изменений:_  

1. _Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность._  
  
Запускаю контейнер из коммита с MR.  
`docker run -d -p 5290:5290 --name=python-api cr.yandex/crpa34hbgsn2rmnok4f7/hello:gitlab-d95e2896`  

2. _Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый._  
  
Прикрепляю скрин к issue и закрываю.  
[Скрин](./images/screenshot_9.png)

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл gitlab-ci.yml;
- Dockerfile; 
- лог успешного выполнения пайплайна;
- решённый Issue.

### Важно 
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.
