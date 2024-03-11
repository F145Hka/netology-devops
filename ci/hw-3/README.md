# Домашнее задание к занятию 9 «Процессы CI/CD»

## Подготовка к выполнению

1. _Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям)._  
Создаю 2 ВМ с помощью terraform  
  
2. _Пропишите в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook](./infrastructure/site.yml) созданные хосты._  
\+  
  
3. _Добавьте в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё._  
\+  
  
4. _Запустите playbook, ожидайте успешного завершения._  
Запускаю и получаю ошибку из-за отсутствия postgresql11. Меняю версию на 12.   
  
5. _Проверьте готовность SonarQube через [браузер](http://localhost:9000)._  
[Скрин](./images/screenshot_1.png)  
  
6. _Зайдите под admin\admin, поменяйте пароль на свой._  
\+  
  
7.  _Проверьте готовность Nexus через [бразуер](http://localhost:8081)._  
[Скрин](./images/screenshot_2.png)  
  
8. _Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ._  
\+  

## Знакомоство с SonarQube

### Основная часть

1. _Создайте новый проект, название произвольное._  
\+  
    
2. _Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube._  
\+  
    
3. _Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ)._  
\+  
  
4. _Проверьте `sonar-scanner --version`._  
[Скрин](./images/screenshot_3.png)  
  
5. _Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`._  
[Скрин](./images/screenshot_4.png)  
  
6. _Посмотрите результат в интерфейсе._  
[Скрин](./images/screenshot_5.png)  
  
7. _Исправьте ошибки, которые он выявил, включая warnings._  
<details>
<summary>Код</summary>

```
index = 0

def increment(index):
    index += 1
    return index
def get_square(numb):
    return numb*numb
def print_numb(numb):
    return "Number is {}".format(numb)


while (index < 10):
    index = increment(index)
    print(get_square(index))
```
</details>
</br>

8. _Запустите анализатор повторно — проверьте, что QG пройдены успешно._  
[Скрин](./images/screenshot_6.png)  
  
9. _Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ._  
[Скрин](./images/screenshot_7.png)  
  

## Знакомство с Nexus

### Основная часть

1. _В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:_  

 *    _groupId: netology;_
 *    _artifactId: java;_
 *    _version: 8_282;_
 *    _classifier: distrib;_
 *    _type: tar.gz._  
[Скрин](./images/screenshot_8.png)  
  
2. _В него же загрузите такой же артефакт, но с version: 8_102._  
[Скрин](./images/screenshot_9.png)  
  
3. _Проверьте, что все файлы загрузились успешно._  
[Скрин](./images/screenshot_10.png)  
  
4. _В ответе пришлите файл `maven-metadata.xml` для этого артефекта._  
[maven-metadata.xml](./maven-metadata.xml)  
  

### Знакомство с Maven

### Подготовка к выполнению

1. _Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi)._  
\+  
  
2. _Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ)._  
\+  
  
3. _Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker._  
  
Удалил блок
```
<mirror>
    <id>maven-default-http-blocker</id>
    <mirrorOf>external:http:*</mirrorOf>
    <name>Pseudo repository to mirror external repositories initially using HTTP.</name>
    <url>http://0.0.0.0/</url>
    <blocked>true</blocked>
</mirror>
```
   
  
4. _Проверьте `mvn --version`._  
```
[centos@fhmkj0jrnli2rkppsr4e ~]$ mvn --version
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/apache-maven
Java version: 1.8.0_402, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.402.b06-1.el7_9.x86_64/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "3.10.0-1160.108.1.el7.x86_64", arch: "amd64", family: "unix"
```  
  
5. _Заберите директорию [mvn](./mvn) с pom._  
\+  

### Основная часть

1. _Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282)._  
\+  
  
2. _Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания._  
[Скрин](./images/screenshot_11.png)  
  
3. _Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт._  
[Скрин](./images/screenshot_15.png)  
  
  
4. _В ответе пришлите исправленный файл `pom.xml`._  
[pom.xml](./mvn/pom.xml)  

---

