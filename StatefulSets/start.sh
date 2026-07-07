#!/bin/bash

namespace="statefulsetplaying"

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

