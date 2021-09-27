#!/bin/bash

if [ "$#" -ne 1 -o \( "$1" != "create_cluster" -a "$1" != "deploy_application" -a "$1" != "destroy_cluster" \) ]; then
    echo "Please specify an action: create_cluster | deploy_application | destroy_cluster"
    exit 1
else
    #output=$(eval "ansible-playbook k8s/$1.yml")
    eval "ansible-playbook k8s/$1.yml"
    #echo "$output"
fi