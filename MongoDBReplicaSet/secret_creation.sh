#!/bin/bash

# Generate keyfile for replica set authentication
openssl rand -base64 756 > keyfile

# Create secret
kubectl create secret generic mongodb-keyfile \
  --from-file=keyfile=keyfile 

# Create admin credentials secret
kubectl create secret generic mongodb-admin \
  --from-literal=username=admin \
  --from-literal=password=$(openssl rand -base64 24)
