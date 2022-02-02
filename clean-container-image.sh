#!/bin/bash

harbor_url=$1
harbor_project_name=$2
project_name=$3
tag=$4

imageName=$harbor_url/$harbor_project_name/$project_name:$tag

echo "$imageName"

imageId=`docker images | grep -w $project_name | awk '{print $3}'`

echo "$imageId"

if [ "${imageId}" != "" ] ; then

        docker rmi -f $imageId

	docker image prune -f

fi
