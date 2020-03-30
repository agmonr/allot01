#!/usr/bin/env bash
set -e

kubectl delete service service-helloworld
kubectl delete deployment helloworld-deployment
