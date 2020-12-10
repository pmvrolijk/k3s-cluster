#!/bin/bash
echo "Apply playbook to cluster - enter sudo password"
ansible-playbook provision_nodes.yml -K -i cluster/hosts
