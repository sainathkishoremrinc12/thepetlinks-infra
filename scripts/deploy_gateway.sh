#!/bin/bash

docker build -t localhost:5000/thepetlinks-gateway:latest ../../services/gateway
docker push localhost:5000/thepetlinks-gateway:latest

helm upgrade --install gateway ../helm/gateway -n petlinks-dev
kubectl delete pod -l app=gateway -n petlinks-dev
kubectl logs -f deployment/gateway-gateway -n petlinks-dev
