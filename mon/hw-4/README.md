# Домашнее задание к занятию 15 «Система сбора логов Elastic Stack»

## Задание 1

_Вам необходимо поднять в докере и связать между собой:_

- _elasticsearch (hot и warm ноды);_
- _logstash;_
- _kibana;_
- _filebeat._

_Logstash следует сконфигурировать для приёма по tcp json-сообщений._

_Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash._

_В директории [help](./help) находится манифест docker-compose и конфигурации filebeat/logstash для быстрого 
выполнения этого задания._  

_Результатом выполнения задания должны быть:_

- _скриншот `docker ps` через 5 минут после старта всех контейнеров (их должно быть 5);_
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_1.png">  

</details>
</br>

- _скриншот интерфейса kibana;_
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_2.png">  

</details>
</br>

- _docker-compose манифест (если вы не использовали директорию help);_  
  
\-
  
- _ваши yml-конфигурации для стека (если вы не использовали директорию help)._
  
\-
  

## Задание 2

_Перейдите в меню [создания index-patterns  в kibana](http://localhost:5601/app/management/kibana/indexPatterns/create) и создайте несколько index-patterns из имеющихся._  

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_3.png">  

</details>
</br>

_Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите, как отображаются логи и как производить поиск по логам._  

\+
  
_В манифесте директории help также приведенно dummy-приложение, которое генерирует рандомные события в stdout-контейнера.
Эти логи должны порождать индекс logstash-* в elasticsearch. Если этого индекса нет — воспользуйтесь советами и источниками из раздела «Дополнительные ссылки» этого задания._

<details>
<summary>Скрины</summary>

<image src="./images/screenshot_4.png">  

</details>
</br>
 
---

 
