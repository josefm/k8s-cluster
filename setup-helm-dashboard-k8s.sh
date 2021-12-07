#!/usr/bin/env bash

# https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard

# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "my-release" using the kubernetes-dashboard chart
helm install my-release kubernetes-dashboard/kubernetes-dashboard


#export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=my-release" -o jsonpath="{.items[0].metadata.name}")
#echo https://127.0.0.1:8443/
#sudo kubectl -n default port-forward $POD_NAME 8443:8443

exit 0