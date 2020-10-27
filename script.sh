#!/bin/bash

# sample value for your variables
MYVARVALUE=$1
MINIO_PORT=$2

# read the yml template from a file and substitute the string 
# {{MYVARNAME}} with the value of the MYVARVALUE variable
# pvc 
template=`cat "pvc.yaml" | sed "s/{{rolename}}/$MYVARVALUE/g"`
echo "$template"
cat pvc.yaml | sed "s/{{rolename}}/$MYVARVALUE/g" | kubectl -n obj apply -f -


template=`cat "minio-pod.yaml" | sed "s/{{rolename}}/$MYVARVALUE/g" | sed "s/{{MINIO_PORT}}/$MINIO_PORT/g"` 
echo "$template"
cat minio-pod.yaml | sed "s/{{rolename}}/$MYVARVALUE/g" | sed "s/{{MINIO_PORT}}/$MINIO_PORT/g" | kubectl -n obj apply -f -


template=`cat "node_pod.yaml" | sed "s/{{rolename}}/$MYVARVALUE/g"`
echo "$template"
cat node_pod.yaml | sed "s/{{rolename}}/$MYVARVALUE/g" | kubectl -n obj apply -f -

# apply the yml with the substituted value
#echo "$template" | kubectl apply -n obj -f -

#echo -n “minio” | base64