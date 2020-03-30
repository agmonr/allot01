#!/usr/bin/env bash
echo "Please make sure you install helm and kubectl"

kubectl create clusterrolebinding sam-view --clusterrole view  --user system:serviceaccount:kube-system:default
kubectl create clusterrolebinding sam-secret-reader --clusterrole secret-reader --user system:serviceaccount:kube-system:default
helm init

# create kubeconfig
aws eks --region eu-west-1 update-kubeconfig --name terraform-eks-demo

helm init
# add repo to helm
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# update local helm repo
helm repo update


