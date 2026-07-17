#!/bin/bash

# *** Init
namespace="helmp"

kubectl delete ns $namespace

# And remove the claim from the PV
kubectl patch pv pv001 -p '{"spec":{"claimRef": null}}'
