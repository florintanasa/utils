#!/bin/bash
docker network create \
	--driver bridge \ # is a brigde
	--subnet 172.18.1.0/24 \ # subnet with network address from 172.18.1.1 - 172.18.1.254, broadcast 172.18.1.255, mask 255.255.255.0
	--ip-range 172.18.1.128/25 \ # ip range from 172.18.1.129 - 172.18.1.254 with GW 172.18.1.128
	punte # network name

