# kub_1_master_2_workers

AWS EC2 + ubuntu 18-04 + all nodes in one VPC



Prepare ubuntu 18-04 on master (control plane)
Turn off swap  
```
swapoff -a
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
apt install -y kubelet kubeadm kubectl btrfs-tools libseccomp2 socat util-linux kubernetes-cni
```

Install High-Availability and Load Balancing
```
apt install keepalived
systemctl enable keepalived && systemctl restart keepalived
sysctl net.bridge.bridge-nf-call-iptables=1
```

On every master node prepare start config  -   create-config.sh
```
./create-config.sh
```

Install first control plane (master node)   cidr= (Your local subnet + mask)
```
kubeadm init --pod-network-cidr=172.31.0.0/20
```

Ooops, we have k8s issue from 2018 , now v1.18.2 version :
```
error: Missing or incomplete configuration info. Please point to an existing, complete config file:

    Via the command-line flag --kubeconfig
    Via the KUBECONFIG environment variable
    In your home directory as ~/.kube/config
```


There is no file ~/.kube/config
Here is example  /etc/kubernetes/admin.conf
Copy it to right location

```
mkdir ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config
```

Check config - 
```
kubectl version

Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T11:56:40Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}

kubectl cluster-info
Kubernetes master is running at https://172.31.8.152:6443
KubeDNS is running at https://172.31.8.152:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

kubectl get pod -n kube-system
NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-6fcbbfb6fb-qnff6   1/1     Running   0          124m
calico-node-qnfc9                          1/1     Running   0          124m
coredns-66bff467f8-sqpzh                   1/1     Running   0          5h20m
coredns-66bff467f8-ztd4j                   1/1     Running   0          5h20m
etcd-k8s-master                            1/1     Running   0          5h21m
kube-apiserver-k8s-master                  1/1     Running   0          5h21m
kube-controller-manager-k8s-master         1/1     Running   0          5h21m
kube-proxy-lv49x                           1/1     Running   0          5h20m
kube-scheduler-k8s-master                  1/1     Running   0          5h21m

```


Install pod network ( i prefer calico)

```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```


