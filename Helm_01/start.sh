#!/bin/bash

# *** Init
helmname="helm01"
helmdir="./test01"
namespace="helmp"

# *** Check if JQ is installed
jq --version 2> /dev/null  1>/dev/null
if [[ $? -ne 0 ]]
then
  echo "ERROR - No JQ installed"
  exit
fi

# *** Create namespace
x=$(kubectl get ns | grep $namespace)
if [[ -z $x ]]
then
  kubectl create ns $namespace
fi

# *** Helm install/upgrade
x=$(helm list --namespace=$namespace -o json | jq .[].name | grep "$helmname")
if [[ -z $x ]]
then
  helm install $helmname $helmdir --namespace=$namespace
else
  echo "** Upgrading **"
  helm upgrade $helmname $helmdir --namespace=$namespace
fi





