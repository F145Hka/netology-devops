1. Полный хэш aefead2207ef7e2aa5dc81a34aedf0cad4c32545, комментарий Update CHANGELOG.md  
Ответ получен командой ***git show aefea***

2.
- 85024d3 - tag: v0.12.23  
Ответ получен командой ***git show 85024d3*** можно добавить агрумент *--oneline*

- 56cd7859e0 9ea88f22fc - родители мерджа b8d720  
Ответ получен командой ***git log -1 b8d720***. Из которорой мы видим строку **Merge: 56cd7859e0 9ea88f22fc**

- хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24  
33ff1c03bb (tag: v0.12.24) v0.12.24  
b14b74c493 [Website] vmc provider links  
3f235065b9 Update CHANGELOG.md  
6ae64e247b registry: Fix panic when server is unreachable  
5c619ca1ba website: Remove links to the getting started guide's old location  
06275647e2 Update CHANGELOG.md  
d5f9411f51 command: Fix bug when using terraform login on Windows  
4b6d06cc5d Update CHANGELOG.md  
dd01a35078 Update CHANGELOG.md  
225466bc3e Cleanup after v0.12.23 release    
Ответ получен командой ***git log v0.12.23..v0.12.24***

- В коммите 8c928e83589d90a031f811fae52a81be7153e82f была создана функция func providerSource  
Ответ получен командой ***git log -S"func providerSource("***. А дальше глазами с помощью команды ***git show 8c928e83589d90a031f811fae52a81be7153e82f*** убеждаемся, что действительно в файле *provider_source.go* была объявлена данная функция.
  
- Используя конструкцию ***git grep -p --break --heading globalPluginDirs*** понимаем, что функция *globalPluginDirs* "живет" в файле *plugins.go*
Далее ищем в этом файле с помощью ***git log -L :globalPluginDirs:plugins.go --oneline*** и видим, что менялась она в коммитах: 78b1220558, 52dbf94834, 41ab0aef7a, 66ebff90cd, 8364383c35
  
- Не уверен на 100%, но функция synchronizedWriters написана Martin Atkins <mart@degeneration.co.uk> и впервые появилась в коммите 5ac311e2a9  
Ответ получен командой ***git log -S synchronizedWriters***