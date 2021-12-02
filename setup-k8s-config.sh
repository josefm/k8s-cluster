#!/usr/bin/env bash

# Problems https://medium.com/@texasdave2/troubleshoot-kubectl-connection-refused-6f5445a396ed

sudo -s kubeadm init --apiserver-advertise-address 192.168.33.13 --pod-network-cidr=10.244.0.0/16 | tee /tmp/kubeadm-init-log.txt

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

sudo sed -i 's/\(^\s*- --port=0\)/#\1/g' /etc/kubernetes/manifests/kube-scheduler.yaml
sudo sed -i 's/\(^\s*- --port=0\)/#\1/g' /etc/kubernetes/manifests/kube-controller-manager.yaml

sudo systemctl restart kubelet.service

exit 0