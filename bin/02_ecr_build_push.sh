#!/usr/bin/env bash
# The script is building "Hello world" docker image and push it to ecr

set -e
#for f in $( docker images | grep demo | grep latest | awk '{ print $3 }' ) ; do
#  docker rmi -f "${f}"
#done


cd ../docker/

URI=$( aws ecr describe-repositories --region eu-west-1 --repository-names "demo" | grep repositoryUri | awk -F\" '{ print $4 }' )

echo "ecr URI: ${URI}"

docker build . -t ${URI} 

echo "Getting ecr login"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin ${URI}
docker push ${URI}

cd -
