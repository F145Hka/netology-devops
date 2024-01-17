### Домашнее задание к занятию 2 «Работа с Playbook»

1. _Подготовьте свой inventory-файл `prod.yml`._  
\+  

2. _Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!_  
\+  

3. _При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`._  
\+  

4. _Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector._  
\+  

5. _Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть._  

<details>
<summary><code>ansible-lint site.yml</code></summary>

```
Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```
</details></br>

6. _Попробуйте запустить playbook на этом окружении с флагом `--check`.
ansible-playbook -i inventory/prod.yml site.yml --extra-vars='ansible_check_mode: true' --check_  

<details>
<summary><code>ansible-playbook -i inventory/prod.yml site.yml --check</code></summary>

```
PLAY [Install ansible modules requirements] *****************************************************************************************
TASK [Gathering Facts] **************************************************************************************************************
ok: [vector-01]
ok: [clickhouse-01]

TASK [Install python-firewall] ******************************************************************************************************
changed: [vector-01]
changed: [clickhouse-01]

TASK [Start and enable firewalld] ***************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service firewalld: host"}
...ignoring
fatal: [vector-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service firewalld: host"}
...ignoring

PLAY [Install Clickhouse] ***********************************************************************************************************
TASK [Gathering Facts] **************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
changed: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] **************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: OSError: Could not open: /tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm /tmp/clickhouse-client-23.9.6.20.x86_64.rpm /tmp/clickhouse-server-23.9.6.20.x86_64.rpm
fatal: [clickhouse-01]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 192.168.233.25 closed.\r\n", "module_stdout": "Traceback (most recent call last):\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518384.353523-201906-68289283095737/AnsiballZ_dnf.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518384.353523-201906-68289283095737/AnsiballZ_dnf.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518384.353523-201906-68289283095737/AnsiballZ_dnf.py\", line 47, in invoke_module\r\n    runpy.run_module(mod_name='ansible.modules.dnf', init_globals=dict(_module_fqn='ansible.modules.dnf', _modlib_path=modlib_path),\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 210, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 97, in _run_module_code\r\n    _run_code(code, mod_globals, init_globals,\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 87, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ke9xnyzi/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1481, in <module>\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ke9xnyzi/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1470, in main\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ke9xnyzi/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1443, in run\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ke9xnyzi/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1088, in ensure\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ke9xnyzi/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 988, in _install_remote_rpms\r\n  File \"/usr/lib/python3.9/site-packages/dnf/base.py\", line 1290, in add_remote_rpms\r\n    raise IOError(_(\"Could not open: {}\").format(' '.join(pkgs_error)))\r\nOSError: Could not open: /tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm /tmp/clickhouse-client-23.9.6.20.x86_64.rpm /tmp/clickhouse-server-23.9.6.20.x86_64.rpm\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}
...ignoring

TASK [Firewall open port] ***********************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (firewall) on netology-centos's Python /usr/bin/python3. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter. Version 0.2.11 or newer required (0.3.9 or newer for offline operations)"}
...ignoring

TASK [Flush handlers] ***************************************************************************************************************

TASK [Pause 20 sec] *****************************************************************************************************************
Pausing for 20 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
Press 'C' to continue the play or 'A' to abort
ok: [clickhouse-01]

TASK [Create database] **************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [vector-01]

TASK [Get vector package] ***********************************************************************************************************
changed: [vector-01]

TASK [Install vector packages] ******************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: OSError: Could not open: /tmp/vector-0.35.0-1.x86_64.rpm
fatal: [vector-01]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 192.168.233.25 closed.\r\n", "module_stdout": "Traceback (most recent call last):\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518389.2283905-201979-17448739135614/AnsiballZ_dnf.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518389.2283905-201979-17448739135614/AnsiballZ_dnf.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518389.2283905-201979-17448739135614/AnsiballZ_dnf.py\", line 47, in invoke_module\r\n    runpy.run_module(mod_name='ansible.modules.dnf', init_globals=dict(_module_fqn='ansible.modules.dnf', _modlib_path=modlib_path),\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 210, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 97, in _run_module_code\r\n    _run_code(code, mod_globals, init_globals,\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 87, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ancru82l/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1481, in <module>\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ancru82l/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1470, in main\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ancru82l/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1443, in run\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ancru82l/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1088, in ensure\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_ancru82l/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 988, in _install_remote_rpms\r\n  File \"/usr/lib/python3.9/site-packages/dnf/base.py\", line 1290, in add_remote_rpms\r\n    raise IOError(_(\"Could not open: {}\").format(' '.join(pkgs_error)))\r\nOSError: Could not open: /tmp/vector-0.35.0-1.x86_64.rpm\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}
...ignoring

TASK [Deploy vector config] *********************************************************************************************************
changed: [vector-01]

TASK [Flush handlers] ***************************************************************************************************************

PLAY RECAP **************************************************************************************************************************
clickhouse-01              : ok=8    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=3
vector-01                  : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=2
```

</details></br>

7. _Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены._  
<details>
<summary><code>ansible-playbook -i inventory/prod.yml site.yml --check</code></summary>

```

PLAY [Install ansible modules requirements] *****************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [vector-01]
ok: [clickhouse-01]

TASK [Install python-firewall] ******************************************************************************************************
changed: [clickhouse-01]
changed: [vector-01]

TASK [Start and enable firewalld] ***************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service firewalld: host"}
...ignoring
fatal: [vector-01]: FAILED! => {"changed": false, "msg": "Could not find the requested service firewalld: host"}
...ignoring

PLAY [Install Clickhouse] ***********************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
changed: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Install clickhouse packages] **************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: OSError: Could not open: /tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm /tmp/clickhouse-client-23.9.6.20.x86_64.rpm /tmp/clickhouse-server-23.9.6.20.x86_64.rpm
fatal: [clickhouse-01]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 192.168.233.25 closed.\r\n", "module_stdout": "Traceback (most recent call last):\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518697.1789174-203627-276411832499818/AnsiballZ_dnf.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518697.1789174-203627-276411832499818/AnsiballZ_dnf.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518697.1789174-203627-276411832499818/AnsiballZ_dnf.py\", line 47, in invoke_module\r\n    runpy.run_module(mod_name='ansible.modules.dnf', init_globals=dict(_module_fqn='ansible.modules.dnf', _modlib_path=modlib_path),\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 210, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 97, in _run_module_code\r\n    _run_code(code, mod_globals, init_globals,\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 87, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_fs5lhhuv/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1481, in <module>\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_fs5lhhuv/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1470, in main\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_fs5lhhuv/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1443, in run\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_fs5lhhuv/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1088, in ensure\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_fs5lhhuv/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 988, in _install_remote_rpms\r\n  File \"/usr/lib/python3.9/site-packages/dnf/base.py\", line 1290, in add_remote_rpms\r\n    raise IOError(_(\"Could not open: {}\").format(' '.join(pkgs_error)))\r\nOSError: Could not open: /tmp/clickhouse-common-static-23.9.6.20.x86_64.rpm /tmp/clickhouse-client-23.9.6.20.x86_64.rpm /tmp/clickhouse-server-23.9.6.20.x86_64.rpm\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}
...ignoring

TASK [Firewall open port] ***********************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (firewall) on netology-centos's Python /usr/bin/python3. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter. Version 0.2.11 or newer required (0.3.9 or newer for offline operations)"}
...ignoring

TASK [Flush handlers] ***************************************************************************************************************

TASK [Pause 20 sec] *****************************************************************************************************************
Pausing for 20 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
Press 'C' to continue the play or 'A' to abort
ok: [clickhouse-01]

TASK [Create database] **************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************
ok: [vector-01]

TASK [Get vector package] ***********************************************************************************************************
changed: [vector-01]

TASK [Install vector packages] ******************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: OSError: Could not open: /tmp/vector-0.35.0-1.x86_64.rpm
fatal: [vector-01]: FAILED! => {"changed": false, "module_stderr": "Shared connection to 192.168.233.25 closed.\r\n", "module_stdout": "Traceback (most recent call last):\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518701.7110503-203694-78553653706066/AnsiballZ_dnf.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518701.7110503-203694-78553653706066/AnsiballZ_dnf.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/root/.ansible/tmp/ansible-tmp-1705518701.7110503-203694-78553653706066/AnsiballZ_dnf.py\", line 47, in invoke_module\r\n    runpy.run_module(mod_name='ansible.modules.dnf', init_globals=dict(_module_fqn='ansible.modules.dnf', _modlib_path=modlib_path),\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 210, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 97, in _run_module_code\r\n    _run_code(code, mod_globals, init_globals,\r\n  File \"/usr/lib64/python3.9/runpy.py\", line 87, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_skxhui53/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1481, in <module>\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_skxhui53/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1470, in main\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_skxhui53/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1443, in run\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_skxhui53/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1088, in ensure\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_skxhui53/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 988, in _install_remote_rpms\r\n  File \"/usr/lib/python3.9/site-packages/dnf/base.py\", line 1290, in add_remote_rpms\r\n    raise IOError(_(\"Could not open: {}\").format(' '.join(pkgs_error)))\r\nOSError: Could not open: /tmp/vector-0.35.0-1.x86_64.rpm\r\n", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}
...ignoring

TASK [Deploy vector config] *********************************************************************************************************
--- before
+++ after: /home/aakutukov/.ansible/tmp/ansible-local-203486uj3znlqw/tmp1_lahikf/vector.yaml.j2
@@ -0,0 +1,11 @@
+sources:
+  in:
+    type: "stdin"
+
+sinks:
+  out:
+    inputs:
+      - "in"
+    type: "console"
+    encoding:
+      codec: "text"

changed: [vector-01]

TASK [Flush handlers] ***************************************************************************************************************

PLAY RECAP **************************************************************************************************************************
clickhouse-01              : ok=8    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=3
vector-01                  : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=2
```

</details></br>

8. _Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен._  
\+  

9. _Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8_  
[README](./playbook/README.md)  

10. _Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него._  
\+

---
