#!/bin/bash

harbor_url=$1
harbor_project_name=$2
project_name=$3
tag=$4
port=$5

imageName=$harbor_url/$harbor_project_name/$project_name:$tag

echo "$imageName"

containerId=`docker ps -a | grep -w ${project_name}:${tag} | awk '{print $1}'`


docker login -u Izumi -p Qwer3936134 $harbor_url

docker pull $imageName

oldImageId=`docker images | grep -w ${project_name} | awk 'NR==2' | awk '{print $3}'`

oldContainerId=`docker ps -a | grep -w ${oldImageId} | awk '{print $1}'`


if [ "${containerId}" != "" ] ; then
        docker stop $containerId

        docker rm $containerId

        docker container prune -f
fi

if [ "${oldImageId}" != "" ] ; then

        docker rmi -f $oldImageId

 docker image prune -f

fi

docker run -d -p $port:$port $imageName

echo "success deploy !"
