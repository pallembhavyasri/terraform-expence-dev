#!/bin/bash

#user data by default has the sudo access 
dnf install ansible -y 
cd /tmp
git clone https://github.com/pallembhavyasri/ansible-roles.git  
cd ansible-roles
ansible-playbook Backend.yaml -e mysql_root_password=ExpenseApp1 #-e is to override the variable value 
ansible-playbook Frontend.yaml 
