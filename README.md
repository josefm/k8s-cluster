# k8s-cluster

Spin up three node cluster:

* 192.168.33.13 master
* 192.168.33.14 worker-1
* 192.168.33.15 worker-2

see the corresponding post from [here](https://baykara.medium.com/setup-own-kubernetes-cluster-via-virtualbox-99a82605bfcc)

* requirements
```
vagrant
virtualbox
```

Fire up vms
``` 
vagrant up
```
To access each machine respectively via 
```
vagrant ssh master
```
in master node

```
1. set root password
2. switch root account
3. kubeadm init --apiserver-advertise-address 192.168.33.13 --pod-network-cidr=10.244.0.0/16
4. remove --port 0 from /etc/kubernetes/manifests/kube-[controller-api| scheduler].yaml
5. join workers to master node
```
for workers
```
vagrant ssh [worker1|worker2]
```

# SOPS

For use sops with Google Cloud, need install gcloud in master execute:
```
$ /vagrant/setup-gcloud.sh
## Login default account with google account
$ gcloud auth application-default login
```

Now you can read or create an encrypted secret file using:
* Create a new file, you need specified a key for encrypt:
```
$ sops --gcp-kms projects/saz-catalog-00002/locations/europe-west4/keyRings/ci-keyring/cryptoKeys/saz-secrets-key secrets.yaml
```
* For edit file you can use only sops (the key for encrypt is specified in secret file):
```
$ sops secrets.yaml
```
For you can save and generate a new version of file, you must make some change for generate a new version, otherwise the file will not change (or will not been created).