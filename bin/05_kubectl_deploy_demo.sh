#!/usr/bin/env bash
set -e

cd ../deploy/
RepoName=demo

Version=$( aws ecr list-images --repository-name demo | grep imageTag | tail -n 1 | awk -F\" '{ print $4 }' )
Uri=$( aws ecr describe-repositories --repository-name ${RepoName} | grep repositoryUri | awk -F\" '{ print $4 }' ):$Version

cat helloworld.yaml-template | sed -e "s|XZXZXZ|$Uri|" > helloworld.yaml 
for f in helloworld-service.yaml helloworld.yaml; do
  kubectl apply -f ${f}
done

set +e
echo -n "Waiting to get url address."
Url="<pending>"
while [ "${Url}" == "<pending>" ]; do
  Url=$( kubectl get services | grep service-helloworld | awk '{ print $4 }' )
  echo -n  '.'
done

echo 
echo -n "Waiting for dns to update."

Status=2
while [ "${Status}" != "0" ]; do
  nslookup ${Url} >> /dev/null; Status=$?
  echo -n  '.'
done


Url=$( kubectl get services | grep service-helloworld | awk '{ print $4 }' )
echo 'Wait for dns to update and then use http://'${Url}' .'

cd - 
