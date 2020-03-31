#!/usr/bin/env bash
# The script is building "Hello world" docker image and push it to ecr

set -e

if [ "$1" == "-d" ]; then
  echo "Deleting images"
  for f in $( docker images | grep demo | awk '{ print $3 }' ) ; do
    docker rmi -f "${f}"
  done
fi


cd ../docker/

URI=$( aws ecr describe-repositories --region eu-west-1 --repository-names "demo" | grep repositoryUri | awk -F\" '{ print $4 }' )

echo "ecr URI: ${URI}"

docker build . -t ${URI}:$( date +%s )

echo "Getting ecr login"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin ${URI}
docker push ${URI}

cd -
