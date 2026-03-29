#!/bin/bash
docker network create \
    # is a brigde
	--driver bridge \
	# subnet with network address from 172.18.2.1 - 172.18.2.254, broadcast 172.18.2.255, mask 255.255.255.0
	--subnet 172.18.2.0/24 \
	# ip range from 172.18.2.129 - 172.18.2.254 with GW 172.18.2.128
	--ip-range 172.18.2.128/25 \
	# interface name for outside docker - used on firewall
	-o "com.docker.network.bridge.name"="br_docker0" \
	# network name on intern docker - used on containers
	punte

