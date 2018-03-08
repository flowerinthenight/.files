#!/bin/bash

VERSION=$1

if [[ -z "${VERSION}" ]]; then
    echo "no version supplied (without the 'v')"
    exit 1
fi

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v${VERSION}/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/
