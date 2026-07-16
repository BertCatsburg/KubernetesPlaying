#!/bin/bash

# *** Init
helmname="mongodb"
helmdir="./MongoDBReplicaSet"

# *** Check if JQ is installed
jq --version 2> /dev/null  1>/dev/null
if [[ $? -ne 0 ]]
then
  echo "ERROR - No JQ installed"
  exit
fi

# *** Helm install/upgrade
x=$(helm list -o json | jq .[].name | grep "$helmname")
if [[ -z $x ]]
then
  helm install $helmname $helmdir
else
  helm upgrade $helmname $helmdir
fi





