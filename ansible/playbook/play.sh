#!/bin/bash
images=("pycontribs/ubuntu" "pycontribs/fedora" "pycontribs/centos:7")
names=("ubuntu" "fedora" "centos7")

for n in ${!names[@]}; do
    docker run --name ${names[n]} -dit ${images[n]}
done

ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

for n in ${names[@]}; do
    echo "Docker stop $n"
    docker stop $n $1>/dev/null
    echo "Docker remove $n" 
    docker rm $n $1>/dev/null
done