#!/bin/bash

if [ "$1" != "www" ] && [ "$1" != "api" ]; then
    echo "first argument must be either `www` or `api`"
    exit 1
fi


docker kill $1
docker rm $1

docker build -t $1 -f $1/Dockerfile .
docker run --name $1 -p $2:80 $1
