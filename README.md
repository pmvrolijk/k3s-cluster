Install HA k3s cluster with external etcd and virtual IP
========================================================

Usage
-----

1. Set up a minimum of three Debian servers (tested on Buster). 
    - Minimal install; Base-utils and SSH server
    - Passwordless (PKI) access for a sudo user
2. Change variables (see below)
3. ./createCerts.sh
4. ./apply.sh
5. wait


Structure
---------

```
.
├── apply.sh                                # Run the provisioning
├── cluster
│   └── hosts                               # Hosts inventory and variables
├── createCertificates.yml                  # Playbook to generate certificates first
├── createCerts.sh                          # Run the createCertificates playbook
├── provision_nodes.yml                     # Playbook to provision the cluster
├── README.md                               # This file...
└── roles
    ├── base                                # Install packages, set user prefs, git
    │   ├── files
    │   │   ├── motd                        # Message of the day
    │   │   └── scripts
    │   │       └── git-prompt.sh           # Pretty Git prompt
    │   ├── handlers
    │   │   └── main.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    ├── docker                              # Install Docker and Docker compose - may be skipped
    │   ├── defaults
    │   │   └── main.yml
    │   ├── handlers
    │   │   └── main.yml
    │   └── tasks
    │       ├── docker-compose.yml
    │       ├── docker-users.yml
    │       ├── main.yml
    │       └── setup-Debian.yml
    ├── etcd                                # Set up an Etcd cluster on the nodes
    │   ├── artifacts                       # Contains the generated keys (createCerts.sh)
    │   │   ├── *.crt
    │   │   ├── *.csr
    │   │   └── *.key
    │   ├── files
    │   │   ├── etcdctl.sh
    │   │   └── etcd.service
    │   ├── handlers
    │   │   └── main.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── etcd.conf.yaml.j2
    ├── golang                              # Set up Golang on the nodes - may be skipped
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    ├── k3s                                 # Install and configure k3s in HA mode using the etcd cluster
    │   ├── handlers
    │   │   └── main.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       ├── config.yaml.j2
    │       └── k3s.service.j2
    └── keepalived                          # Install and configure Keepalived to provide a Virtual IP address
        ├── handlers
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        └── templates
            └── keepalived.conf.j2
```

Variables (in cluster/hosts)
----------------------------

*    cluster_name: "k3s-cluster"            # Name of the cluster, also used for the dns of the virtual IP -> "k3s_cluster_vip"
*    ansible_user: "debby"                  # User with ssh access for Ansible
*    my_user: "debby"                       # User to add to Docker, whose home directory to set up, etc
*    my_email: "debby@example.com"          # For Git
*    my_name: "Debby"                       # For Git
*    new_go_version: "1.15.4"               # Go version to install (unless newer version is already installed)
*    docker_compose_version: "1.27.4"       # Docker compose version to install (unless newer version is already installed)
*    docker_apt_release_channel: stable     # Docker repo to use 
*    docker_users:                          # List of users to add to Docker group
*        - debby
*    vip_iface: "enp0s3"                    # The interface to be used for keepalive
*    vip_addr: "10.0.0.54"                  # Vip address to configure (hardcoded netmask /24, see Keepalive role)
*    vip_password: "StrongPassword01"       # Password for Keepalived agents' communication
*    vip_check_kubernetes: False            # Whether to incluse the k8s api port 6443 in the Keepalived healthcheck
*    etcd_version: "3.4.13"                 # Etcd version to install (unless newer version is already installed)
*    new_k3s_version: "1.19.4+k3s2"         # K3s version to install (unless newer version is already installed)
*    k3s_use_docker: True                   # Configure k3s to use Docker rather than containerd


