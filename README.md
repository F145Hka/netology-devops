# netology-devops

Файл .gitignore внутри каталога terraform указывает гиту игнорировать следущее:

Любые файлы внутри скрытого каталога .terraform, который находится внутри любого кататалога, относительно .gitignore

Любые файлы с расширением tfstate, а так же файлы c двойным расширением, где первое - tfstate, а второе любое.

Файлы crash.log, а так же файлы crash с двойным расширением, где первое расширение любое, а второе log

Любые файлы с расширением tfvars, а так же файлы с двойным расширением tfvars.json 

Файлы override.tf, override.tf.json, а так же файлы с расширениями tf и tf.json, в конце имени корых присутствует _override.

Скрытые файлы .terraform, а так же файлы terraform.rc
new line
new line
new line