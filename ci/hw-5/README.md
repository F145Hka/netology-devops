# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. _В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`._  
  
\+  

2. _Дождитесь запуска teamcity, выполните первоначальную настройку._  
  
\+  

3. _Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_5.png">  

</details>
</br>

4. _Авторизуйте агент._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_6.png">  

</details>
</br>

5. _Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity)._  
  
\+  
  
6. _Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure)._  
  
\+  

## Основная часть

1. _Создайте новый проект в teamcity на основе fork._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_1.png">  

</details>
</br>

2. _Сделайте autodetect конфигурации._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_2.png">  

</details>
</br>

3. _Сохраните необходимые шаги, запустите первую сборку master._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_3.png">  

</details>
</br>

4. _Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_4.png">  

</details>
</br>

5. _Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_7.png">  

</details>
</br>

6. _В pom.xml необходимо поменять ссылки на репозиторий и nexus._  
  
\+  
  

7. _Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_8.png">  

</details>
</br>

8. _Мигрируйте `build configuration` в репозиторий._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_9.png">  

</details>
</br>

[Ссылка на конфигурацию](https://github.com/F145Hka/example-teamcity/tree/master/.teamcity/Netology)  

9. _Создайте отдельную ветку `feature/add_reply` в репозитории._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_10.png">  

</details>
</br>

10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
```
public String sayNeedGas(){
                 return "Need more Vespene gas, hunter!";
	}
```
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
```
@Test
	public void welcomerSaysNeedGas(){
		assertThat(welcomer.sayNeedGas(), containsString("hunter"));
	}
```
12. _Сделайте push всех изменений в новую ветку репозитория._  
  
  \+  
  
13. _Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_11.png">  

</details>
</br>

14. _Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`._  
  
  \+

15. _Убедитесь, что нет собранного артефакта в сборке по ветке `master`._  
  
  \+  
  
16. _Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки._  

Проверяю `pom.xml` и в нем же меняю версию, так как сборка с версией 0.0.2 уже былы сделана в п.7  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_13.png">  

</details>
</br>

17. _Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны._  
<details>
<summary>Скрины</summary>

<image src="./images/screenshot_14.png">  
<image src="./images/screenshot_15.png">  

</details>
</br>

18. _Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity._  
  
  \+

19. _В ответе пришлите ссылку на репозиторий._  
  
[Ссылка на репозиторий](https://github.com/F145Hka/example-teamcity)  
