#!/usr/bin/env bash
# https://docs.aws.amazon.com/eks/latest/userguide/calico.html
cd ../docker/

kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.5/config/v1.5/calico.yaml

kubectl get daemonset calico-node --namespace kube-system

cd - 
