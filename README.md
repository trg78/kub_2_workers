# kub_1_master_2_workers


Prepare ubuntu 18-04 on master (control plane)
Turn off swap  
```
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```


Rename  
```
echo "k8s-master" > /etc/hostname
reboot
```


Continue , every block separately  
```
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo apt install software-properties-common
```

add repo -   nano /etc/apt/sources.list
```
deb http://us-east-2.ec2.archive.ubuntu.com/ubuntu/ bionic main restricted
deb http://us-east-2.ec2.archive.ubuntu.com/ubuntu/ bionic-updates main restricted
deb http://archive.canonical.com/ubuntu bionic partner
deb-src http://archive.canonical.com/ubuntu bionic partner
deb http://us-east-2.ec2.archive.ubuntu.com/ubuntu/ bionic multiverse
deb http://us-east-2.ec2.archive.ubuntu.com/ubuntu/ bionic-updates multiverse
deb http://security.ubuntu.com/ubuntu bionic-security main restricted
deb-src http://security.ubuntu.com/ubuntu bionic-security main restricted
deb http://security.ubuntu.com/ubuntu bionic-security universe
deb-src http://security.ubuntu.com/ubuntu bionic-security universe
deb http://security.ubuntu.com/ubuntu bionic-security multiverse
deb-src http://security.ubuntu.com/ubuntu bionic-security multiverse
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
deb-src [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
deb http://apt.kubernetes.io/ kubernetes-xenial main
deb-src http://apt.kubernetes.io/ kubernetes-xenial main
```


```
apt update
apt install docker-ce docker-ce-cli containerd.io
```


Install kubernetes
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-get install -y kubelet kubeadm kubectl
```

Install High-Availability and Load Balancing
```
apt install keepalived
systemctl enable keepalived && systemctl restart keepalived
sysctl net.bridge.bridge-nf-call-iptables=1
```

Prepare start config  nano create-config.sh
```

```
