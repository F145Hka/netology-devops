
# Домашнее задание к занятию «Микросервисы: принципы»

_Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации._  

## Задача 1: API Gateway 

_Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения._  

_Решение должно соответствовать следующим требованиям:_  
_- маршрутизация запросов к нужному сервису на основе конфигурации,_
_- возможность проверки аутентификационной информации в запросах,_
_- обеспечение терминации HTTPS._

_Обоснуйте свой выбор._


Для реализации API Gateway в микросервисной архитектуре с учетом требований, рассмотрим несколько популярных решений:

| Решение         | Маршрутизация | Аутентификация | HTTPS |
|-----------------|---------------|----------------|-------|
| Kong            | Да            | Да             | Да    |
| Tyk             | Да            | Да             | Да    |
| Apigee          | Да            | Да             | Да    |
| AWS API Gateway | Да            | Да             | Да    |
| Nginx           | Да            | Да             | Да    |
| Traefik         | Да            | Да             | Да    |
| Yandex API Gateway | Да          | Да             | Да    |

Выбор решения зависит от конкретных потребностей и условий вашего проекта. Однако, рассмотрим несколько факторов:

1. **Гибкость настройки**: Kong, Tyk, NGINX и Traefik предоставляют более гибкие инструменты для настройки и расширения функциональности API Gateway.

2. **Совместимость с облачными сервисами**: AWS API Gateway,Apigee, Yandex API Gateway облачные решения, что может упростить интеграцию с другими сервисами в облаке.

3. **Стоимость**: Стоимость использования может быть важным фактором. Nginx и Traefik бесплатны в отличии от облачных сервисов, таких как Apigee, AWS API Gateway и Yandex API Gateway.

На основе этих факторов я бы рекомендовал использовать Kong, Nginx, или Traefik. Kong имеет бесплатную версию, которая так же удовлетворяет условиям.

## Задача 2: Брокер сообщений

_Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения._

_Решение должно соответствовать следующим требованиям:_
_- поддержка кластеризации для обеспечения надёжности,_
_- хранение сообщений на диске в процессе доставки,_
_- высокая скорость работы,_
_- поддержка различных форматов сообщений,_
_- разделение прав доступа к различным потокам сообщений,_
_- простота эксплуатации._

_Обоснуйте свой выбор._

Для выбора брокера сообщений, удовлетворяющего требованиям, рассмотрим несколько популярных решений:

| Решение       | Кластеризация | Хранение на диске | Скорость работы | Поддержка форматов | Разделение прав | Простота эксплуатации |
|---------------|---------------|-------------------|-----------------|--------------------|-----------------|-----------------------|
| Apache Kafka  | Да            | Да                | Высокая         | JSON, Avro, Protobuf, XML, ... | Да              | Средняя               |
| RabbitMQ      | Да            | Да                | Высокая         | JSON, XML, Protobuf, ... | Да              | Высокая               |
| ActiveMQ      | Да            | Да                | Высокая         | JSON, XML, CSV, ... | Да              | Средняя               |
| NATS          | Да            | Да                | Очень высокая   | JSON, Protobuf, ... | Нет             | Высокая               |
| Redis         | Да            | Да                | Очень высокая   | Любой формат       | Да              | Высокая               |

Исходя из требований и характеристик решений, мой выбор - Redis. Вот почему:

1. **Надёжность и кластеризация**: Redis поддерживает кластеризацию для обеспечения надёжности, что позволяет гарантировать высокую доступность и отказоустойчивость.

2. **Хранение на диске и скорость работы**: Redis обладает высокой скоростью работы и поддерживает хранение данных на диске, что обеспечивает сохранность сообщений в случае сбоев.

3. **Поддержка различных форматов сообщений**: Redis позволяет работать с данными в различных форматах, включая любой пользовательский формат, что делает его универсальным решением для обработки сообщений различных типов.

4. **Разделение прав доступа**: Redis поддерживает механизмы аутентификации и авторизации, позволяя настраивать разделение прав доступа к различным потокам сообщений.

5. **Простота эксплуатации**: Redis обладает простым в использовании интерфейсом и хорошо документирован, что упрощает его внедрение и поддержку.

Таким образом, Redis сочетает в себе необходимые функциональности и характеристики для успешной реализации брокера сообщений в микросервисной архитектуре.

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- _хранит загруженные файлы в бакете images,_
- _S3 протокол,_

**uploader**
- _принимает файл, если картинка сжимает и загружает его в minio,_
- _POST /v1/upload,_

**security**
- _регистрация пользователя POST /v1/user,_
- _получение информации о пользователе GET /v1/user,_
- _логин пользователя POST /v1/token,_
- _проверка токена GET /v1/token/validation._

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
1. _Анонимный доступ.
2. _Запрос направляется в сервис security POST /v1/user._

**POST /v1/token**
1. _Анонимный доступ._
2. _Запрос направляется в сервис security POST /v1/token._

**GET /v1/user**
1. _Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/._
2. _Запрос направляется в сервис security GET /v1/user._

**POST /v1/upload**
1. _Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/._
2. _Запрос направляется в сервис uploader POST /v1/upload._

**GET /v1/user/{image}**
1. _Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/._
2. _Запрос направляется в сервис minio GET /images/{image}._

### Ожидаемый результат

_Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для Nginx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token_

**Загрузка файла**

_curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload_

**Получение файла**
_curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg_

<details>
<summary><b>Вывод консоли</b></summary>

```
❯ docker-compose up --build -d
[+] Building 1.9s (22/22) FINISHED                                                                                                                                           docker:default
 => [uploader internal] load build definition from Dockerfile                                                                                                                          0.0s
 => => transferring dockerfile: 144B                                                                                                                                                   0.0s
 => [uploader internal] load metadata for docker.io/library/node:alpine                                                                                                                1.4s
 => [security internal] load build definition from Dockerfile                                                                                                                          0.0s
 => => transferring dockerfile: 180B                                                                                                                                                   0.0s
 => [security internal] load metadata for docker.io/library/python:3.9-alpine                                                                                                          1.7s
 => [uploader auth] library/node:pull token for registry-1.docker.io                                                                                                                   0.0s
 => [security auth] library/python:pull token for registry-1.docker.io                                                                                                                 0.0s
 => [uploader internal] load .dockerignore                                                                                                                                             0.0s
 => => transferring context: 52B                                                                                                                                                       0.0s
 => [uploader 1/5] FROM docker.io/library/node:alpine@sha256:181d0e0248e825fa1c056c7ef85e91fbad340caf0814d30b81467daea4637045                                                          0.0s
 => [uploader internal] load build context                                                                                                                                             0.0s
 => => transferring context: 92.62kB                                                                                                                                                   0.0s
 => CACHED [uploader 2/5] WORKDIR /app                                                                                                                                                 0.0s
 => CACHED [uploader 3/5] COPY package*.json ./                                                                                                                                        0.0s
 => CACHED [uploader 4/5] RUN npm install                                                                                                                                              0.0s
 => CACHED [uploader 5/5] COPY src ./                                                                                                                                                  0.0s
 => [uploader] exporting to image                                                                                                                                                      0.0s
 => => exporting layers                                                                                                                                                                0.0s
 => => writing image sha256:30e743a1d7692f3a79ab644fc04b2517b79cbcc9a389a0a7cd8ce0d96a71a232                                                                                           0.0s
 => => naming to docker.io/library/hw-2-uploader                                                                                                                                       0.0s
 => [security internal] load .dockerignore                                                                                                                                             0.0s
 => => transferring context: 2B                                                                                                                                                        0.0s
 => [security 1/5] FROM docker.io/library/python:3.9-alpine@sha256:99161d2323b4130fed2d849dc8ba35274d1e1f35da170435627b21d305dad954                                                    0.0s
 => [security internal] load build context                                                                                                                                             0.0s
 => => transferring context: 2.50kB                                                                                                                                                    0.0s
 => CACHED [security 2/5] WORKDIR /app                                                                                                                                                 0.0s
 => CACHED [security 3/5] COPY requirements.txt .                                                                                                                                      0.0s
 => CACHED [security 4/5] RUN pip install -r requirements.txt                                                                                                                          0.0s
 => CACHED [security 5/5] COPY src ./                                                                                                                                                  0.0s
 => [security] exporting to image                                                                                                                                                      0.0s
 => => exporting layers                                                                                                                                                                0.0s
 => => writing image sha256:e25e78bad3e1663cf8b3be9221ff8419b1e0995c2999ba650ce39bf7ac1ea21f                                                                                           0.0s
 => => naming to docker.io/library/hw-2-security                                                                                                                                       0.0s
[+] Running 6/6
 ✔ Network hw-2_default     Created                                                                                                                                                    0.1s
 ✔ Container security       Started                                                                                                                                                    0.8s
 ✔ Container storage        Started                                                                                                                                                    0.9s
 ✔ Container createbuckets  Started                                                                                                                                                    1.2s
 ✔ Container uploader       Started                                                                                                                                                    1.8s
 ✔ Container gateway        Started                                                                                                                                                    2.2s
❯ curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/v1/token
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I%
❯ curl -X POST \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' \
  -H 'Content-Type: application/octet-stream' \
  --data-binary @0001.jpg \
  http://localhost/v1/upload
{"filename":"bc8fa1be-6eae-4e70-a24d-8de272d2d9ce.jpg"}%
❯ curl -X GET http://localhost/v1/user/bc8fa1be-6eae-4e70-a24d-8de272d2d9ce.jpg > 2.jpg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   383  100   383    0     0   118k      0 --:--:-- --:--:-- --:--:--  124k
```
</details>
</br>

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

_Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории._

---