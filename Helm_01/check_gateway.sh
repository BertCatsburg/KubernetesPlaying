#!/bin/bash

# *** Init
source ./lib/init.sh

# *** Generations should be the same as Observed Generations
# See: https://gateway-api.sigs.k8s.io/docs/concepts/troubleshooting/
gatewayname=$(kubectl get gateway -n $namespace | grep -v "NAME" | awk '{print $1}')
generations=$(kubectl describe gateway/$gatewayname -n $namespace | grep Generation | grep -v "Observed" | awk '{print $2}')
observed_generations=$(kubectl describe gateway/$gatewayname -n $namespace | grep "Observed Generation"  | awk '{print $2}')

error_flag=false
for i in $(kubectl describe gateway/$gatewayname -n $namespace | grep "Observed Generation"  | awk '{print $3}')
do
  if [ "$i" != "$generations" ]
  then
    error_flag=true
  fi
done
if [ "$error_flag" = true ]
then
  echo "ERROR - Some of the Observed Generations are not the same as the Generations in the $namespace/$gatewayname"
  echo "        To investigate: $ kubectl describe gateway/$gatewayname -n $namespace"
fi

# *** Show all Gateway resources
echo "*** The Gateway Class"
kubectl get gatewayclass

echo "**********************************"
echo "*** Gateway"
kubectl describe gateway/bertgateway -n $namespace


echo "**********************************"
echo "*** HTTP Route"
kubectl describe httproute/bertgateway-httproute -n $namespace

echo "**********************************"
echo "*** Backend Ref : Service"
kubectl describe service/webserver -n $namespace



