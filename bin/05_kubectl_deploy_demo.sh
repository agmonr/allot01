#!/usr/bin/env bash
set -e

cd ../deploy/
RepoName=demo
Uri=$( aws ecr describe-repositories --repository-name ${RepoName} | grep repositoryUri | awk -F\" '{ print $4 }' )
cat helloworld.yaml-template | sed -e "s|XZXZXZ|$Uri|" > helloworld.yaml 
for f in helloworld-service.yaml helloworld.yaml; do
  kubectl apply -f ${f}
done

Url=$( kubectl get services | grep service-helloworld | awk '{ print $4 }' )
echo 'Wait for dns to update and then use http://'${Url}' .'

cd - 
