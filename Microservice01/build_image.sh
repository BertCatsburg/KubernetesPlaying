#!/bin/bash

imagename="myapp:0.0.6"
# *** Test if the local registry is running
x=$(docker ps --format '{{.Names}}' | grep "registry")
if [ -z "$x" ]
then
  echo "*** ERROR - Local Registry not running ***"
  exit
fi

# *** Build the image and put it in local registry
docker buildx build \
  -t localhost:5000/$imagename \
  .

docker push localhost:5000/$imagename