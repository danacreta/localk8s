#!/bin/bash

#######################################
# Bash script to install localk8s reuiered apps on Ubuntu
# Written by @DanaCreta
#######################################

## Update packages and Upgrade system
sudo apt-get update -y

## minikube ##
if command -v minikube >/dev/null 2>&1; then
    echo "###minikube already here!"
else
    echo "###Getting minikube.."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    echo "###Installing minikube.."
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

## kubectl ##
if command -v kubectl >/dev/null 2>&1; then
    echo "###kubectl already here!"
else 
    echo "###Get kubectl.."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    echo "###Installing kubectl.."
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

## openshift ##
echo "###python3-pip installing.."
sudo apt install python3-pip

echo "###openshift installing.."
pip3 install openshift

## Ansible ##
echo '###Installing ansible..'
sudo pip3 install ansible

# Ansible Kubernetes 
echo '###Ansible Kubernetes ..'
ansible-galaxy collection install community.kubernetes
