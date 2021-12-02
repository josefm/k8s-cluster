1. Crear token en master:
master# kubeadm token create

2. Conectar nodo, con el token creado:
nodo# kubeadm join 192.168.33.13:6443 --token symqbs.tuetnd6waz2vpd2s --discovery-token-unsafe-skip-ca-verification

# Kubernetes

* Deployments: Las subidas de una imagen a un/varios pod/s.
kubectl get deployments
* Services: Es la puerta de entrada al kubernete, el que se encarga de mapear los puertos del kubernete al pod que corresponda.
kubectl get services
* Pods: Donde se meteran las imagenes de docker.
kubectl get pods
* Nodos: Son las instancias conectadas al cluster.
kubectl get nodes


Mirar puertos abiertos:
sudo netstat -tulpn | grep LISTEN