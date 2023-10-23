### Задача 1
1.  - Сокращение сроков вывода продукта на рынок.  
    - Простота масштабирования.  
    - Более быстрая разработка.  
    - Уверенность в том, что на одинаковых серверах дествительно одинаковые настройки.  
    - Сокращение стоимости и сроков обнаружения и исправления дефектов, а так же добавления нового функционала.  
    - Автоматическое развертывание новых версий при каждом изменении кода в репозитории.  

2. Идемпотентность - повторяемость результата выполнения операций.
  
### Задача 2
Ansible обладает низким порогом входа, не требует установки агентов на целевые машины.
Обладает yaml-подобным синтаксисом.

Если говорить о надежности, то на мой взгляд, pull-модель более надежная, так как если говорить о полностью динамической среде, то появившийся сервер может забрать конфигурацию с мастера, а в push-модели нужно описать все известные серверы изначально.
  
### Задача 3
❯ **ansible --version**  
ansible [core 2.15.4]  
  config file = None  
  configured module search path = ['/home/aakutukov/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']  
  ansible python module location = /usr/lib/python3.11/site-packages/ansible  
  ansible collection location = /home/aakutukov/.ansible/collections:/usr/share/ansible/collections  
  executable location = /usr/bin/ansible  
  python version = 3.11.5 (main, Sep  2 2023, 14:16:33) [GCC 13.2.1 20230801] (/usr/bin/python)  
  jinja version = 3.1.2  
  libyaml = True  

❯ **terraform -v**  
Terraform v1.5.7  
on linux_amd64  
  
Your version of Terraform is out of date! The latest version  
is 1.6.2. You can update by downloading from https://www.terraform.io/downloads.html  
  
❯ **vagrant -v**  
Vagrant 2.3.7 
   
❯ **vboxmanage -v**  
7.0.10r158379  
  
### Задача 4
❯ **vagrant up**  
```Bringing machine 'server1.netology' up with 'virtualbox' provider...  
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...  
==> server1.netology: Matching MAC address for NAT networking...  
==> server1.netology: Setting the name of the VM: server1.netology  
==> server1.netology: Clearing any previously set network interfaces...  
==> server1.netology: Preparing network interfaces based on configuration...  
    server1.netology: Adapter 1: nat  
    server1.netology: Adapter 2: hostonly  
==> server1.netology: Forwarding ports...  
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)  
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)  
==> server1.netology: Running 'pre-boot' VM customizations...  
==> server1.netology: Booting VM...  
==> server1.netology: Waiting for machine to boot. This may take a few minutes...  
    server1.netology: SSH address: 127.0.0.1:2222  
    server1.netology: SSH username: vagrant  
    server1.netology: SSH auth method: private key  
    server1.netology:   
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace  
    server1.netology: this with a newly generated keypair for better security.  
    server1.netology:   
    server1.netology: Inserting generated public key within guest...  
    server1.netology: Removing insecure key from the guest if it's present...  
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...  
==> server1.netology: Machine booted and ready!  
==> server1.netology: Checking for guest additions in VM...  
==> server1.netology: Setting hostname...  
==> server1.netology: Configuring and enabling network interfaces...  
==> server1.netology: Mounting shared folders...  
    server1.netology: /vagrant => /home/aakutukov/Projects/netology/netology-devops/virt/vagrant  
==> server1.netology: Running provisioner: ansible...  
    server1.netology: Running ansible-playbook...  
  
PLAY [nodes] *******************************************************************  
  
TASK [Gathering Facts] *********************************************************  
ok: [server1.netology]  
  
TASK [Create directory for ssh-keys] *******************************************  
ok: [server1.netology]  
  
TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************  
changed: [server1.netology]  
  
TASK [Checking DNS] ************************************************************  
changed: [server1.netology]  
  
TASK [Installing tools] ********************************************************  
ok: [server1.netology] => (item=git)  
ok: [server1.netology] => (item=curl)  
  
TASK [Installing docker] *******************************************************  
changed: [server1.netology]  
  
TASK [Add the current user to docker group] ************************************  
changed: [server1.netology]  
  
PLAY RECAP *********************************************************************  
server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0```