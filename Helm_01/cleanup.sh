#!/bin/bash

# *** Init
helmname="helm01"
helmdir="./cluster01"
namespace="helmp"

helm uninstall $helmname
kubectl delete ns $namespace

# And remove the claim from the PV
kubectl patch pv pv001 -p '{"spec":{"claimRef": null}}'
