#!/bin/bash

#######################################
# all masters settings below must be same
#######################################

# master01 ip address
export K8SHA_IP1=10.73.71.25 

# master02 ip address
export K8SHA_IP2=10.73.71.26

# master03 ip address
export K8SHA_IP3=10.73.71.27

# master01 hostname
export K8SHA_HOSTNAME1=master01

# master02 hostname
export K8SHA_HOSTNAME2=master02

# master03 hostname
export K8SHA_HOSTNAME3=master03

#etcd tocken:
export ETCD_TOKEN=9489bf67bdfe1b3ae077d6fd9e7efefd

#etcd version
export ETCD_VERSION="v3.3.10"
