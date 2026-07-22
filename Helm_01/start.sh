#!/bin/bash

# *** Init
helmname="helm01"
helmdir="./cluster01"
namespace="helmp"
websiteDir="./simpleWebsite"
websiteImageName="simplewebsite"
websiteImageVersion="0.0.2"
websiteImage="$websiteImageName:$websiteImageVersion"
valuesFile="./cluster01/values.yaml"

# *** Check if JQ is installed
jq --version 2> /dev/null  1>/dev/null
if [[ $? -ne 0 ]]
then
  echo "ERROR - No JQ installed"
  exit
fi

# *** Build the image
#docker buildx build --tag $websiteImageName:$websiteImageVersion --file $websiteDir/Dockerfile $websiteDir/

## *** Create namespace
#x=$(kubectl get ns | grep $namespace)
#if [[ -z $x ]]
#then
#  kubectl create ns $namespace
#fi


## *** Create and Install the Gateway Class
#x=$(kubectl get crd | grep -e "gateway.networking.k8s.io" | wc | awk '{print $1}')
#if [[ $x -eq 8 ]]
#then
#  echo "SUCCESS - Gateway API Custom Resource Definition already installed"
#else
#  echo "WARNING - No Gateway API Custom Resource Definition found. About to load and install"
#  kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v2.6.3" | kubectl apply -f -
#fi
#
#x=$(kubectl get all -n nginx-gateway 2>&1 | wc | awk '{print $1}')
#if [[ $x -eq 1 ]]
#then
#  echo "WARNING - Gateway API not installed. About to run the helm script"
#  helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric --create-namespace -n nginx-gateway
#else
#  echo "SUCCESS - Gateway API already installed"
#fi

# *** Add the latest image to values.yaml in Helm Chart
cat $valuesFile; echo ""


#
## *** Helm install/upgrade
#x=$(helm list --namespace=$namespace -o json | jq .[].name | grep "$helmname")
#if [[ -z $x ]]
#then
#  helm install $helmname $helmdir --namespace=$namespace
#else
#  echo "** Upgrading **"
#  helm upgrade $helmname $helmdir --namespace=$namespace
#fi





