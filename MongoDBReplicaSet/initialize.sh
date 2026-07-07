#!/bin/bash

# Wait for all pods to be running
kubectl wait --for=condition=Ready pod/mongodb-0  --timeout=300s
kubectl wait --for=condition=Ready pod/mongodb-1  --timeout=300s
kubectl wait --for=condition=Ready pod/mongodb-2  --timeout=300s

# Connect to primary and initialize replica set
kubectl exec -it mongodb-0  -- mongosh

# In mongosh shell:
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-0.mongodb-headless.mongodbreplication.svc.cluster.local:27017", priority: 2 },
    { _id: 1, host: "mongodb-1.mongodb-headless.mongodbreplication.svc.cluster.local:27017", priority: 1 },
    { _id: 2, host: "mongodb-2.mongodb-headless.mongodbreplication.svc.cluster.local:27017", priority: 1 }
  ]
})

# Verify replica set status
rs.status()