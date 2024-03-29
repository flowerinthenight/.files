#!/bin/bash

$1 version &>/dev/null
if [ $? -eq 0 ]; then
  ln -sf $GOPATH/bin/$1 $HOME/.local/bin/go
  go version
  exit 0
fi

go install golang.org/dl/$1@latest && $1 download
ln -sf $GOPATH/bin/$1 $HOME/.local/bin/go
go version
