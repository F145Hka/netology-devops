# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. _Получить бесплатную версию Jira - https://www.atlassian.com/ru/software/jira/work-management/free (скопируйте ссылку в адресную строку). Вы можете воспользоваться любым(в том числе бесплатным vpn сервисом) если сайт у вас недоступен. Кроме того вы можете скачать [docker образ](https://hub.docker.com/r/atlassian/jira-software/#) и запустить на своем хосте self-managed версию jira._  
  
Взял docker-образ.  
  
2. _Настроить её для своей команды разработки._
    
\+  
    
3. _Создать доски Kanban и Scrum._  

Создал [доски](./images/screenshot_12.png)  

4. _[Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/)._  

## Основная часть

_Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:_  

1. _Open -> On reproduce._
2. _On reproduce -> Open, Done reproduce._
3. _Done reproduce -> On fix._
4. _On fix -> On reproduce, Done fix._
5. _Done fix -> On test._
6. _On test -> On fix, Done._
7. _Done -> Closed, Open._  
  
Создал [bug workflow](./images/screenshot_13.png)

_Остальные задачи должны проходить по упрощённому workflow:_  
  
1. _Open -> On develop._
2. _On develop -> Open, Done develop._
3. _Done develop -> On test._
4. _On test -> On develop, Done._
5. _Done -> Closed, Open._  
  
Создал [simplified workflow](./images/screenshot_14.png)  

**Что нужно сделать**

1. _Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done._  
[Провел по workflow](./images/screenshot_15.png)  
2. _Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done._  
[Провел по workflow](./images/screenshot_16.png)  
3. _При проведении обеих задач по статусам используйте kanban._  
\+  

4. _Верните задачи в статус Open._  
[Вернул в open](./images/screenshot_17.png)  
5. _Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт._  
[Запланировал спринт](./images/screenshot_18.png)  
[Завершил спринт](./images/screenshot_19.png)  
[Завершенный спринт](./images/screenshot_20.png)  
6. _Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания._  
[bug_workflow.xml](./bug_workflow.xml)  
[simplified_workflow.xml](./simplified_workflow.xml)    

---