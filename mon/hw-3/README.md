# Домашнее задание к занятию 14 «Средство визуализации Grafana»

### Задание 1

1. _Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana._  
```
cd help
docker-compose up -d
```

2. _Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_1.png">  

</details>
</br>

3. _Подключите поднятый вами prometheus, как источник данных._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_2.png">
  
</details>
</br>

4. _Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_3.png">
  
</details>
</br>

## Задание 2

_Изучите самостоятельно ресурсы:_  

1. _[PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085)._  
2. _[Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage)._  
3. _[Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/)._  

_Создайте Dashboard и в ней создайте Panels:_  

- утилизация CPU для nodeexporter (в процентах, 100-idle);
```
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter", mode="idle"}[5m])) * 100)
```

- CPULA 1/5/15;
```
node_load1{job="nodeexporter"}
node_load5{job="nodeexporter"}
node_load15{job="nodeexporter"}
```

- количество свободной оперативной памяти;
```
node_memory_MemFree_bytes{job='nodeexporter'}
```

- количество места на файловой системе.
```
node_filesystem_avail_bytes{job="nodeexporter", mountpoint="/"}
```

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_4.png">
  
</details>
</br>

## Задание 3

1. _Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг»._  
  
\+  
    
2. _В качестве решения задания приведите скриншот вашей итоговой Dashboard._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_5.png">
  
</details>
</br>

## Задание 4

1. _Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его._  
  
\+
  
2. _В качестве решения задания приведите листинг этого файла._  
  
[dashboard.json](./dashboard.json)

---
