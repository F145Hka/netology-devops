# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. _Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`._  
[terraform код](./terraform/)

2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. _Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse._  
\+  
2. _При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`._  
\+  
3. _Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер._  
\+  
4. _Подготовьте свой inventory-файл `prod.yml`._  
\+  
5. _Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть._  
[Скрин](./img/screenshot_8.png)
6. _Попробуйте запустить playbook на этом окружении с флагом `--check`._  
<details>
<summary><code>ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --check --start-at-task="Install Nginx and Git"</code></summary>

```
❯ ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --check --start-at-task="Install Nginx and Git"

PLAY [Install ansible modules requirements] ****************************************************************************

PLAY [Install Clickhouse] **********************************************************************************************

PLAY [Install Vector] **************************************************************************************************

PLAY [Install Lighthouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [lighthouse-01]

TASK [Install Nginx and Git] *******************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "No package matching 'nginx' found available, installed or updated", "rc": 126, "results": ["No package matching 'nginx' found available, installed or updated"]}
...ignoring

TASK [Start Nginx] *****************************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service nginx: host"}
...ignoring

TASK [Create directory] ************************************************************************************************
[WARNING]: failed to look up user nginx. Create user up to this point in real play
[WARNING]: failed to look up group nginx. Create group up to this point in real play
changed: [lighthouse-01]

TASK [Clone lighthouse repo] *******************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "Failed to find required executable \"git\" in paths: /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin"}
...ignoring

TASK [Deploy nginx config] *********************************************************************************************
changed: [lighthouse-01]

TASK [Add SELinux permissions] *****************************************************************************************
skipping: [lighthouse-01]

TASK [Flush handlers] **************************************************************************************************

PLAY RECAP *************************************************************************************************************
lighthouse-01              : ok=6    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=3

❯ ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --check

PLAY [Install ansible modules requirements] ****************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Install python-firewall] *****************************************************************************************
changed: [clickhouse-01]

TASK [Start and enable firewalld] **************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service firewalld: host"}
...ignoring

PLAY [Install Clickhouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
changed: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] *************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching '/tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm' found on system", "rc": 127, "results": ["No RPM file matching '/tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm' found on system"]}
...ignoring

TASK [Firewall open port] **********************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (firewall) on fhmgtd8jud2rlh5t5sbr.auto.internal's Python /usr/bin/python. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter. Version 0.2.11 or newer required (0.3.9 or newer for offline operations)"}
...ignoring

TASK [Flush handlers] **************************************************************************************************

TASK [Pause 20 sec] ****************************************************************************************************
Pausing for 20 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
Press 'C' to continue the play or 'A' to abort
ok: [clickhouse-01]

TASK [Create database] *************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [vector-01]

TASK [Get vector package] **********************************************************************************************
changed: [vector-01]

TASK [Install vector packages] *****************************************************************************************
fatal: [vector-01]: FAILED! => {"changed": false, "msg": "No RPM file matching '/tmp/vector-0.35.0-1.x86_64.rpm' found on system", "rc": 127, "results": ["No RPM file matching '/tmp/vector-0.35.0-1.x86_64.rpm' found on system"]}
...ignoring

TASK [Deploy vector config] ********************************************************************************************
changed: [vector-01]

TASK [Flush handlers] **************************************************************************************************

PLAY [Install Lighthouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [lighthouse-01]

TASK [Add EPEL Repo] ***************************************************************************************************
changed: [lighthouse-01]

TASK [Install Nginx and Git] *******************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "No package matching 'nginx' found available, installed or updated", "rc": 126, "results": ["No package matching 'nginx' found available, installed or updated"]}
...ignoring

TASK [Start Nginx] *****************************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service nginx: host"}
...ignoring

TASK [Create directory] ************************************************************************************************
[WARNING]: failed to look up user nginx. Create user up to this point in real play
[WARNING]: failed to look up group nginx. Create group up to this point in real play
changed: [lighthouse-01]

TASK [Clone lighthouse repo] *******************************************************************************************
fatal: [lighthouse-01]: FAILED! => {"changed": false, "msg": "Failed to find required executable \"git\" in paths: /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin"}
...ignoring

TASK [Deploy nginx config] *********************************************************************************************
changed: [lighthouse-01]

TASK [Add SELinux permissions] *****************************************************************************************
skipping: [lighthouse-01]

TASK [Flush handlers] **************************************************************************************************

PLAY RECAP *************************************************************************************************************
clickhouse-01              : ok=8    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=3
lighthouse-01              : ok=7    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=3
vector-01                  : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1
```

</details>
</br>

[Скрин](./img/screenshot_9.png)

7. _Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены._  
<details>
<summary><code>ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --diff</code></summary>

```
❯ ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --diff

PLAY [Install ansible modules requirements] ****************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Install python-firewall] *****************************************************************************************
changed: [clickhouse-01]

TASK [Start and enable firewalld] **************************************************************************************
changed: [clickhouse-01]

PLAY [Install Clickhouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
changed: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] *************************************************************************************
changed: [clickhouse-01]

TASK [Firewall open port] **********************************************************************************************
changed: [clickhouse-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Start clickhouse service] *****************************************************************************
changed: [clickhouse-01]

TASK [Pause 20 sec] ****************************************************************************************************
Pausing for 20 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [clickhouse-01]

TASK [Create database] *************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [vector-01]

TASK [Get vector package] **********************************************************************************************
changed: [vector-01]

TASK [Install vector packages] *****************************************************************************************
changed: [vector-01]

TASK [Deploy vector config] ********************************************************************************************
--- before: /etc/vector/vector.yaml
+++ after: /home/aakutukov/.ansible/tmp/ansible-local-329870jig0qrg0/tmploymfn52/vector.yaml.j2
@@ -1,47 +1,11 @@
-#                                    __   __  __
-#                                    \ \ / / / /
-#                                     \ V / / /
-#                                      \_/  \/
-#
-#                                    V E C T O R
-#                                   Configuration
-#
-# ------------------------------------------------------------------------------
-# Website: https://vector.dev
-# Docs: https://vector.dev/docs
-# Chat: https://chat.vector.dev
-# ------------------------------------------------------------------------------
+sources:
+  in:
+    type: "stdin"

-# Change this to use a non-default directory for Vector data storage:
-# data_dir: "/var/lib/vector"
-
-# Random Syslog-formatted logs
-sources:
-  dummy_logs:
-    type: "demo_logs"
-    format: "syslog"
-    interval: 1
-
-# Parse Syslog logs
-# See the Vector Remap Language reference for more info: https://vrl.dev
-transforms:
-  parse_logs:
-    type: "remap"
-    inputs: ["dummy_logs"]
-    source: |
-      . = parse_syslog!(string!(.message))
-
-# Print parsed logs to stdout
 sinks:
-  print:
+  out:
+    inputs:
+      - "in"
     type: "console"
-    inputs: ["parse_logs"]
     encoding:
-      codec: "json"
-
-# Vector's GraphQL API (disabled by default)
-# Uncomment to try it out with the `vector top` command or
-# in your browser at http://localhost:8686
-# api:
-#   enabled: true
-#   address: "127.0.0.1:8686"
+      codec: "text"

changed: [vector-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Start vector service] *********************************************************************************
changed: [vector-01]

PLAY [Install Lighthouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [lighthouse-01]

TASK [Add EPEL Repo] ***************************************************************************************************
changed: [lighthouse-01]

TASK [Install Nginx and Git] *******************************************************************************************
changed: [lighthouse-01]

TASK [Start Nginx] *****************************************************************************************************
changed: [lighthouse-01]

TASK [Create directory] ************************************************************************************************
--- before
+++ after
@@ -1,6 +1,6 @@
 {
-    "group": 0,
-    "owner": 0,
+    "group": 994,
+    "owner": 997,
     "path": "/var/www/lighthouse",
-    "state": "absent"
+    "state": "directory"
 }

changed: [lighthouse-01]

TASK [Clone lighthouse repo] *******************************************************************************************
>> Newly checked out d701335c25cd1bb9b5155711190bad8ab852c2ce
changed: [lighthouse-01]

TASK [Deploy nginx config] *********************************************************************************************
--- before
+++ after: /home/aakutukov/.ansible/tmp/ansible-local-329870jig0qrg0/tmp64_l5529/lighthouse.conf.j2
@@ -0,0 +1,12 @@
+server {
+  listen        80;
+  server_name   localhost;
+
+  access_log    /var/log/nginx/lighthouse_access.log;
+  error_log    /var/log/nginx/lighthouse_error.log;
+
+  location / {
+    root  /var/www/lighthouse;
+    index index.html;
+  }
+}
\ No newline at end of file

changed: [lighthouse-01]

TASK [Add SELinux permissions] *****************************************************************************************
changed: [lighthouse-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Restart nginx] ****************************************************************************************
changed: [lighthouse-01]

PLAY RECAP *************************************************************************************************************
clickhouse-01              : ok=10   changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lighthouse-01              : ok=9    changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

</details>
</br>

[Скрин](./img/screenshot_10.png)

8. _Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен._  

<details>
<summary><code>ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --diff</code></summary>

```
❯ ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --diff

PLAY [Install ansible modules requirements] ****************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Install python-firewall] *****************************************************************************************
ok: [clickhouse-01]

TASK [Start and enable firewalld] **************************************************************************************
ok: [clickhouse-01]

PLAY [Install Clickhouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] *************************************************************************************
ok: [clickhouse-01]

TASK [Firewall open port] **********************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] **************************************************************************************************

TASK [Pause 20 sec] ****************************************************************************************************
Pausing for 20 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
Press 'C' to continue the play or 'A' to abort
ok: [clickhouse-01]

TASK [Create database] *************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [vector-01]

TASK [Get vector package] **********************************************************************************************
ok: [vector-01]

TASK [Install vector packages] *****************************************************************************************
ok: [vector-01]

TASK [Deploy vector config] ********************************************************************************************
ok: [vector-01]

TASK [Flush handlers] **************************************************************************************************

PLAY [Install Lighthouse] **********************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [lighthouse-01]

TASK [Add EPEL Repo] ***************************************************************************************************
ok: [lighthouse-01]

TASK [Install Nginx and Git] *******************************************************************************************
ok: [lighthouse-01]

TASK [Start Nginx] *****************************************************************************************************
ok: [lighthouse-01]

TASK [Create directory] ************************************************************************************************
changed: [lighthouse-01]

TASK [Clone lighthouse repo] *******************************************************************************************
changed: [lighthouse-01]

TASK [Deploy nginx config] *********************************************************************************************
ok: [lighthouse-01]

TASK [Add SELinux permissions] *****************************************************************************************
changed: [lighthouse-01]

TASK [Flush handlers] **************************************************************************************************

RUNNING HANDLER [Restart nginx] ****************************************************************************************
changed: [lighthouse-01]

PLAY RECAP *************************************************************************************************************
clickhouse-01              : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lighthouse-01              : ok=9    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

</details>
</br>

[Скрин](./img/screenshot_11.png)

9. _Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги._  
[README.md](./playbook/README.md)  
10. _Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него._  
\+  

---
