#!/bin/bash

ACTION=$1

if [ $ACTION = "start" ]; then
    echo "start rabbitmq docker..."
    docker run -d --name rabbitmq --restart=always -p 5672:5672 -p 15672:15672 rabbitmq:management
fi

if [ $ACTION = "stop" ]; then
    echo "stop rabbitmq docker..."
    docker stop rabbitmq && docker rm rabbitmq && docker system prune -f
fi
