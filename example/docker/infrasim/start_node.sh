#!/bin/bash -x

CONTAINER=infrasim_1
INTERFACE=eth0
BRIDGE=br0

# create the infrasim container
#docker create -it --net=docker_southbound --privileged --name $CONTAINER infrasim/infrasim-compute:3.5.1

# add the admin network to it
#docker network connect docker_admin infrasim_1

# start the container
#docker start $CONTAINER

# copy the vnode config to the container
#docker cp default.yml $CONTAINER:/root/.infrasim/.node_map

# get the IP for the bridge 
#IP=$(docker exec $CONTAINER ifconfig $INTERFACE | awk '/inet addr/{print substr($2,6)}')

IP=$(ifconfig $INTERFACE | awk '/inet addr/{print substr($2,6)}')
echo $IP

# config the bridge interface and start the virtual node
#docker exec -i $CONTAINER bash <<EOF
ifconfig $INTERFACE 0.0.0.0
ifconfig $INTERFACE promisc
brctl addbr br0
brctl addif br0 $INTERFACE
brctl setfd br0 0
brctl sethello br0 1
brctl stp br0 no
ifconfig br0 $IP
ifconfig br0 up
ifconfig
infrasim node start
#EOF


