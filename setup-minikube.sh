#!/usr/bin/env bash

## Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu hirsute stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt update \
    && apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    && sudo usermod -aG docker vagrant \
    && newgrp docker

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && install minikube-linux-amd64 /usr/local/bin/minikube


#echo -e "${INFO}Starting minikube ... IF PROCESS FREEZES, stop the execution (CTRL + C) and execute again.${WHITE}"
#minikube start --driver=none --memory='3g' --disk-size='2g' --nodes=6 --v=8 --cpus=4 \
#--delete-on-failure --extra-config=kubeadm.ignore-preflight-errors=SystemVerification,FileExisting-ip \
#--wait-timeout=1m
#
## Use minikube docker
#eval $(minikube docker-env)
#
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
#
#echo -e "${INFO}Creating user token...${WHITE}"
#kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
#echo -e "${INFO}END of token${WHITE}"
#
#kubectl create clusterrolebinding system:serviceaccount:kube-system:deployment-controller-view --clusterrole view --user system:serviceaccount:kube-system:deployment-controller
#
#minikube addons enable ingress

exit 0

minikube start --driver=docker --memory='3g' --disk-size='2g' --nodes=6 --v=8 --cpus=2 --delete-on-failure --wait-timeout=1m
eval $(minikube docker-env)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
kubectl create clusterrolebinding system:serviceaccount:kube-system:deployment-controller-view --clusterrole view --user system:serviceaccount:kube-system:deployment-controller
minikube addons enable ingress