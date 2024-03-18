# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. _Создать два VM: для jenkins-master и jenkins-agent._  
Создаю 2 ВМ с помощью terraform.  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_1.png">  

</details>
</br>
  
2. _Установить Jenkins при помощи playbook._  
\+  
  
3. _Запустить и проверить работоспособность._  
\+  
  
4. _Сделать первоначальную настройку._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_2.png">  
<image src="./images/screenshot_3.png">  

</details>
</br>

## Основная часть

1. _Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_4.png">  
<image src="./images/screenshot_5.png">  
<image src="./images/screenshot_6.png">  
<image src="./images/screenshot_7.png">  
<image src="./images/screenshot_8.png">  

</details>
</br>

2. _Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_9.png">  
<image src="./images/screenshot_10.png">  

</details>
</br>

3. _Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`._  
  
Выложил в репозиторий - [Jenkinsfile](https://github.com/F145Hka/netology-jenkins/blob/main/Jenkinsfile)  
  
4. _Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_11.png">  
<image src="./images/screenshot_13.png">  
<image src="./images/screenshot_14.png">  
<image src="./images/screenshot_15.png">  

</details>
</br>

5. _Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline)._  
\+ 
  
6. _Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`._  

Создал параметр `prod_run`. При каждом запуске пайпа запрашивается этот параметр. Внутри пайпа проверяется истинность параметра.
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_16.png">  
<image src="./images/screenshot_17.png">  
<image src="./images/screenshot_18.png">  

</details>
</br>

7. _Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_19.png">  
<image src="./images/screenshot_20.png">  

</details>
</br>

8. _Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline._  
[Declarative Pipeline](https://github.com/F145Hka/netology-jenkins/blob/main/Jenkinsfile)  
[Scripted Pipeline](https://github.com/F145Hka/netology-jenkins/blob/main/ScriptedJenkinsfile)

9. _Сопроводите процесс настройки скриншотами для каждого пункта задания!!_  
\+  

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
