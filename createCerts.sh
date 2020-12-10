#!/bin/bash
echo "Create certificates for etcd on all hosts"
ansible-playbook -i cluster/hosts createCertificates.yml
