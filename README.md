.
├── apply.sh
├── cluster
│   └── hosts
├── createCertificates.yml
├── createCerts.sh
├── k3s_install
│   └── k3s
│       ├── install.sh
│       └── settings.sh
├── provision_nodes.yml
├── README.md
└── roles
    ├── base
    │   ├── files
    │   │   ├── motd
    │   │   └── scripts
    │   │       ├── etcdctl.sh
    │   │       └── git-prompt.sh
    │   ├── handlers
    │   │   └── main.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    ├── docker
    │   ├── defaults
    │   │   └── main.yml
    │   ├── handlers
    │   │   └── main.yml
    │   └── tasks
    │       ├── docker-compose.yml
    │       ├── docker-users.yml
    │       ├── main.yml
    │       └── setup-Debian.yml
    ├── etcd
    │   ├── artifacts
    │   ├── files
    │   │   ├── etcdctl.sh
    │   │   └── etcd.service
    │   ├── handlers
    │   │   └── main.yml
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── etcd.conf.yaml.j2
    ├── golang
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    └── keepalived
        ├── handlers
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        └── templates
            └── keepalived.conf.j2

27 directories, 30 files
