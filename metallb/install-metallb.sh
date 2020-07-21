#!/bin/bash

kubectl apply -f namespace.yaml
kubectl apply -f metallb.yaml
kubectl apply -f metallb-config.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system