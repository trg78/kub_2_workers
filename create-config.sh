#!/bin/bash

# local machine ip address
export K8SHA_IPLOCAL=172.26.133.21

# local machine etcd name, options: etcd1, etcd2, etcd3, etcd4, etcd5
export K8SHA_ETCDNAME=etcd1

# local machine keepalived state config, options: MASTER, BACKUP. One keepalived cluster only one MASTER, other's are BACKUP
export K8SHA_KA_STATE=MASTER

# local machine keepalived priority config, options: 102, 101, 100, 99, 98. MASTER must 102
export K8SHA_KA_PRIO=102

# local machine keepalived network interface name config, for example: eth0
export K8SHA_KA_INTF=eth0

#######################################
# all masters settings below must be same
#######################################

# master keepalived virtual ip address
export K8SHA_IPVIRTUAL=172.26.133.20

# master01 ip address
export K8SHA_IP1=172.26.133.152

# master02 ip address
# export K8SHA_IP2=172.26.133.22

# master03 ip address
# export K8SHA_IP3=172.26.133.23

# master04 ip address
# export K8SHA_IP4=172.26.133.24

# master05 ip address
# export K8SHA_IP5=172.26.133.25

# master01 hostname
# export K8SHA_HOSTNAME1=k8s-master

# master02 hostname
# export K8SHA_HOSTNAME2=hb-master02

# master03 hostname
# export K8SHA_HOSTNAME3=hb-master03

# master04 hostname
# export K8SHA_HOSTNAME4=hb-master04

# master04 hostname
# export K8SHA_HOSTNAME4=hb-master05

# keepalived auth_pass config, all masters must be same
export K8SHA_KA_AUTH=55df7dc334c90194d1600c483e10acfr

# kubernetes cluster token, you can use 'kubeadm token generate' to get a new one
export K8SHA_TOKEN=gliyp1.e5vtyrbz0tnpbe86

# kubernetes CIDR pod subnet, if CIDR pod subnet is "10.244.0.0/16" please set to "10.244.0.0\\/16"
export K8SHA_CIDR=172.26.133.0\\/20

##############################
# please do not modify anything below
##############################
