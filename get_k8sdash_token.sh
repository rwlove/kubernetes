#!/bin/bash

# Create the service account in the current namespace (we assume default)
kubectl create serviceaccount k8dash-sa

# Give that service account root on the cluster
kubectl create clusterrolebinding k8dash-sa --clusterrole=cluster-admin --serviceaccount=default:k8dash-sa

# Find the secret that was created to hold the token for the SA
token = `kubectl get secrets | grep k8dash-sa-token | awk {'print $1'}`

# Show the contents of the secret to extract the token
kubectl describe secret ${token}
