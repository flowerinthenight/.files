#!/bin/bash

gofile=$1
if [[ -z "${gofile// }" ]]; then
    echo "Please provide the golang package filename."
else
    url="https://storage.googleapis.com/golang/$gofile"
    curl -O $url
    tar xvf $gofile
    ls -laF ./go/
    ls -laF /usr/local/go/
    sudo rm -rfv /usr/local/go
    sudo mv ./go /usr/local/
    sudo chown -R root:root /usr/local/go/
    rm $gofile
    go version
fi
