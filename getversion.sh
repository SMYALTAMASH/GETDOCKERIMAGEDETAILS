#!/bin/bash

accountName=sunbird

images=$(curl -s "https://registry.hub.docker.com/v2/repositories/$accountName/?page_size=8192" | jq '."results"[]["name"]'| tr -d '\n' | tr "\"" " ")

#echo $images
for i in ${images[@]} 
do 
echo "The $i Image versions and creation dates are:-"
curl -s "https://registry.hub.docker.com/v2/repositories/$accountName/$i/tags/" | jq '."results"[]["name"]+ " on "+ ."results"[]["last_updated"]' | sed 's/\"//g' | awk '{print substr($0, 1, length($0)-17)}'
echo -e  "----------------------------------\n"
done
