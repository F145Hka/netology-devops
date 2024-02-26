# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. _Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman`._  
\+  
2. _Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри._  
\+  

## Основная часть

_Ваша цель — настроить тестирование ваших ролей._  

_Задача — сделать сценарии тестирования для vector._  

_Ожидаемый результат — все сценарии успешно проходят тестирование ролей._  

### Molecule

1. _Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования._  
  
Починил сценарий и запустил `molecule test -s centos7`  

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_1.png">  
<image src="./images/screenshot_2.png">  
<image src="./images/screenshot_3.png">  
<image src="./images/screenshot_4.png">  
<image src="./images/screenshot_5.png">  
<image src="./images/screenshot_6.png">  
<image src="./images/screenshot_7.png">  
<image src="./images/screenshot_8.png">  
<image src="./images/screenshot_9.png">  
<image src="./images/screenshot_10.png">  
<image src="./images/screenshot_11.png">  
<image src="./images/screenshot_12.png">  
<image src="./images/screenshot_13.png">  
<image src="./images/screenshot_14.png">  
<image src="./images/screenshot_15.png">  
</details>
</br>

2. _Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`._
  
\+   
  
3. _Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть._  
  
Добавил centos 7 и centos 8, так как роль написана под RHEL.  

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_16.png">  
<image src="./images/screenshot_17.png">  

</details>
</br>

4. _Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.)._  

<details>
<summary>assert</summary>

```
- name: Verify
  hosts: all
  gather_facts: true
  tasks:
    - name: Validate installation
      ansible.builtin.command: "vector --version"
      changed_when: false
      register: vector_ver
    - name: Check vector config
      ansible.builtin.assert:
        that: "vector_ver.rc == 0"
        success_msg: "Installation is valid"
        fail_msg: "Installation is not valid"
    - name: Validate vector config
      ansible.builtin.command: "vector validate --no-environment --config-yaml /etc/vector/vector.yaml"
      changed_when: false
      register: vector_config
    - name: Check vector config
      ansible.builtin.assert:
        that: "vector_config.rc == 0"
        success_msg: "Config is valid"
        fail_msg: "Config is not valid"
```

</details> 
</br>

Запускаю и получаю ошибку установки из-за смены URL репозитория CentOS.  

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_18.png">  
<image src="./images/screenshot_19.png">  
<image src="./images/screenshot_20.png">  

</details>
</br>

5. _Запустите тестирование роли повторно и проверьте, что оно прошло успешно._  
  
Исправил ошибки, запускаю повторно.  

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_21.png">  
<image src="./images/screenshot_22.png">  
<image src="./images/screenshot_23.png">  
<image src="./images/screenshot_24.png">  

</details>
</br>

5. _Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием._  
  
[1.0.1](https://github.com/F145Hka/ansible-vector-role/tree/1.0.1)

### Tox

1. _Добавьте в директорию с vector-role файлы из [директории](./example)._  
  
\+  

2. _Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе._  

`docker run --privileged=True -v $(pwd):/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`  

3. _Внутри контейнера выполните команду `tox`, посмотрите на вывод._  
  
Вывод неутешительный, так как у меня нет сценария `compatibility`. Меняю в `tox.ini` на `default` и снова запускаю. Теперь проблема в отсутствующем docker.

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_25.png">  
<image src="./images/screenshot_26.png">  

</details>
</br>

5. _Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость._  
  
Создаю новый сценарий `molecule init scenario --driver-name podman podman`  

6. _Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий._  
  
Так же для проверки с `python 3.9` добавил `ansible>=3.5` 


```
[tox]
minversion = 1.8
basepython = python3.6
envlist = py{37,39}-ansible{210,30,35}
skipsdist = true

[testenv]
passenv = *
setenv = 
    ANSIBLE_ROLES_PATH="/opt"
deps =
    -r tox-requirements.txt
    ansible210: ansible<3.0
    ansible30: ansible<3.1
    ansible35: ansible>=3.5
commands =
    {posargs:molecule test -s podman --destroy always}
```  
8. _Запустите команду `tox`. Убедитесь, что всё отработало успешно._  
  
Тестирование показало, что исходная конфигурация работает только с `python 3.7`  
<image src="./images/screenshot_27.png">  
</br>
  
Моя новая конфигурация с `python 3.9` и `ansible 8.7.0` проходит проверку успешно.
`tox -e py39-ansible35`  
<image src="./images/screenshot_28.png">  
</br>

9. _Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием._  
  
[1.0.2](https://github.com/F145Hka/ansible-vector-role/tree/1.0.2)

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.
