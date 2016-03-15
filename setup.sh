#!/bin/bash

ssh-keygen -t rsa

cat ~/.ssh/id_rsa.pub | ssh snell@snell.ciena.com 'mkdir -p ~/.ssh && \
	cat >> ~/.ssh/authorized_keys && \
	chmod 700 ~/.ssh && \
	chmod 640 ~/.ssh/authorized_keys && \
	echo master > /etc/hostname'

wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install netaddr --upgrade

sudo echo 'pipelining = True
control_path=/tmp/ansible-ssh-%%h-%%p-%%r' >> /etc/ansible/ansible.cfg

ansible-playbook -i inventory.example.single_master cluster.yml --private-key=~/.ssh/id_rsa
