#!/usr/bin/env bash

# Problems https://medium.com/@texasdave2/troubleshoot-kubectl-connection-refused-6f5445a396ed

sudo -s kubeadm init --apiserver-advertise-address 192.168.33.13 --pod-network-cidr=10.244.0.0/16 | tee /tmp/kubeadm-init-log.txt

# For common user (vagrant) use config folder
sudo --user=vagrant mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown 1000:1000 /home/vagrant/.kube/config

# For root user use environment
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" | tee -a $HOME/.bashrc

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

sudo sed -i 's/\(^\s*- --port=0\)/#\1/g' /etc/kubernetes/manifests/kube-scheduler.yaml
sudo sed -i 's/\(^\s*- --port=0\)/#\1/g' /etc/kubernetes/manifests/kube-controller-manager.yaml

# Execute also on load for avoid restarts of k8s
sudo systemctl restart kubelet.service

exit 0