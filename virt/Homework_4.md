❯ ansible-playbook -i inventory provision.yml

```PLAY [nodes] ********************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Create directory for ssh-keys] ********************************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] *****************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Checking DNS] *************************************************************************************************************************************************************************
changed: [node01.netology.cloud]

TASK [Installing tools] *********************************************************************************************************************************************************************
ok: [node01.netology.cloud] => (item=git)
ok: [node01.netology.cloud] => (item=apt-transport-https)
ok: [node01.netology.cloud] => (item=ca-certificates)
ok: [node01.netology.cloud] => (item=wget)
ok: [node01.netology.cloud] => (item=software-properties-common)
ok: [node01.netology.cloud] => (item=gnupg2)
ok: [node01.netology.cloud] => (item=curl)

TASK [Add Apt signing key from official docker repo] ****************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [add docker official repository for Debian Stretch] ************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Index new repo into the cache] ********************************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Installing docker package] ************************************************************************************************************************************************************
ok: [node01.netology.cloud] => (item=docker-ce)
ok: [node01.netology.cloud] => (item=docker-ce-cli)
ok: [node01.netology.cloud] => (item=containerd.io)

TASK [Enable docker daemon] *****************************************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Install docker-compose] ***************************************************************************************************************************************************************
changed: [node01.netology.cloud]

TASK [Synchronization] **********************************************************************************************************************************************************************
ok: [node01.netology.cloud]

TASK [Pull all images in compose] ***********************************************************************************************************************************************************
changed: [node01.netology.cloud]

TASK [Up all services in compose] ***********************************************************************************************************************************************************
changed: [node01.netology.cloud]

PLAY RECAP **********************************************************************************************************************************************************************************
node01.netology.cloud      : ok=14   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
    
debian@node01:~$ sudo docker ps -a
```CONTAINER ID        IMAGE                              COMMAND                  CREATED             STATUS                   PORTS                                                                              NAMES
f819c078c083        grafana/grafana:7.4.2              "/run.sh"                7 minutes ago       Up 3 minutes             3000/tcp                                                                           grafana
38ddba15fb0c        gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   7 minutes ago       Up 3 minutes (healthy)   8080/tcp                                                                           cadvisor
a181e4296a99        prom/pushgateway:v1.2.0            "/bin/pushgateway"       7 minutes ago       Up 3 minutes             9091/tcp                                                                           pushgateway
7fd8a7ed3ec3        prom/prometheus:v2.17.1            "/bin/prometheus --c…"   7 minutes ago       Up 3 minutes             9090/tcp                                                                           prometheus
96183f84ddad        prom/node-exporter:v0.18.1         "/bin/node_exporter …"   7 minutes ago       Up 3 minutes             9100/tcp                                                                           nodeexporter
0d05b0476c13        prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   7 minutes ago       Up 3 minutes             9093/tcp                                                                           alertmanager
74a1049c3a27        stefanprodan/caddy                 "/sbin/tini -- caddy…"   7 minutes ago       Up 3 minutes             0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 0.0.0.0:9093->9093/tcp   caddy```
