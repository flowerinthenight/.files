#!/bin/bash

kubectl describe nodes | grep -A 2 -e "^\\s*CPU Requests"
echo
echo
kubectl top node
