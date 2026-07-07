#!/bin/bash

namespace="mongodbreplication"

# **** Use separate namespace, and set as default
# - Create the namespace
_x=$(kubectl get namespace | grep -e "^$namespace")
if [[ ${#_x} -eq 0 ]]
then
  echo "Creating namespace \"$namespace\""
  kubectl create ns $namespace
fi
# - Set the default namespace
_x=$(kubectl config view | grep "namespace: $namespace")
if [[ ${#_x} -eq 0 ]]
then
  echo "Setting default namespace to \"$namespace\""
  kubectl config set-context --current --namespace=$namespace > /dev/null
fi
ns=$(kubectl config view -o json | jq .contexts[0].context.namespace)
echo "Context-Namespace is $ns"

cat <<EOF
*************************************************
Source: https://oneuptime.com/blog/post/2026-01-25-mongodb-replica-sets-kubernetes/view
    or: https://github.com/oneuptime/blog/tree/master/posts/2026-01-25-mongodb-replica-sets-kubernetes

Apply in the following order:

./secret_creation.sh
kubectl apply -f clusterip_service.yaml
kubectl apply -f headless_service.yaml
kubectl apply -f configmap.yaml    # This one contains a init script for MongoDB-RS
kubectl apply -f statefulset.yaml

And for the namespace, check the following files:
- configmap.yaml
- initialize.sh

Connect from an Application:
  // Connection string for applications in the same namespace
  mongodb://admin:password@mongodb-0.mongodb-headless.mongodb.svc.cluster.local:27017,mongodb-1.mongodb-headless.mongodb.svc.cluster.local:27017,mongodb-2.mongodb-headless.mongodb.svc.cluster.local:27017/?replicaSet=rs0&authSource=admin

  // For quick in-cluster testing, a Service can be used as an initial seed.
  // For application deployments, prefer the full pod seed list above.
  mongodb://admin:password@mongodb.mongodb.svc.cluster.local:27017/?replicaSet=rs0&authSource=admin
*************************************************
EOF