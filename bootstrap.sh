#!/bin/sh
# see https://blog.alexellis.io/kubernetes-in-10-minutes/

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo sh -c "echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list"
sudo apt-get update
sudo apt-get install -yq apt-transport-https kubelet kubeadm kubernetes-cni docker.io
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable docker.service
