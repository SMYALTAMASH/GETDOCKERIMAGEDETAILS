#!/bin/bash
#bash removeUnwantedNewtowkFromDockerSwarmContainers.sh networkToRemove
if [ $# -ne 1 ];
then
        echo "usage: bash removeUnwantedNewtowkFromDockerSwarmContainers.sh networkToRemove"
        exit 1
fi
services=( $(docker service ls | awk 'NR>1{print $2}' | tr "\n" " ") )
network=$1

for service in ${services[@]};
do
        echo "removing network:$network from service:$service "
        docker service update --network-rm $network $service
done
