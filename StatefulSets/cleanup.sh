#!/bin/bash

namespace="statefulsetplaying"

# **** Delete the Namespace
_x=$(kubectl get namespace | grep -e "^$namespace")
if [[ ${#_x} -gt 0 ]]
then
  echo "Deleting namespace \"$namespace\""
  kubectl delete ns $namespace
fi