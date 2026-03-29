#!/usr/bin/env bash
set -euo pipefail

# Declare some variable
BridgeName="br_docker0"
NETname="punte"
Subnet="172.18.2.0/24"
IPrange="172.18.2.128/25"
IPstatic="172.18.2.2"
#Version="sts" # Short Term Support
Version="latest" # Long Term Support

error() {
  echo -e "\e[91m$1\e[39m" >&2
  exit 1
}

check_internet() {
  printf "Checking internet connectivity... "
  curl -fsI https://github.com >/dev/null || error "Offline. Connect to the internet and retry."
  echo "Online."
}

check_internet

# Ensure the portainer container is not already exist
if docker ps -a -q --filter "name=^/portainer$" | grep -q .; then
    error 'A container named 'portainer' already exists.\n
You can stop and remove first using: docker stop portainer && docker rm portainer'
fi

# Ensure the required ports are free
for p in 8000 9443; do
  if ss -ltn | grep -q ":$p "; then
    error "Port $p is already in use. Free it before running the script."
  fi
done

# Ensure the bridge network '$NETname' not exist
if ! docker network inspect "$NETname" >/dev/null 2>&1; then
    echo "Creating network $NETname... "
    docker network create \
        --driver bridge \
        --subnet "$Subnet" \
        --ip-range "$IPrange" \
        -o "com.docker.network.bridge.name"="$BridgeName" \
        "$NETname" || error "Failed to create network."
    echo "Done."
else
    error "Network $NETname already exists."
fi

# Create the volume
docker volume inspect portainer_data >/dev/null 2>&1 \
  || docker volume create portainer_data || error "Failed to create volume."

# Pull the latest image and start the container
docker run -d --pull=always \
    -p 8000:8000 -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --network="$NETname" --ip "$IPstatic" \
    portainer/portainer-ce:"$Version" \
  || error "Failed to start Portainer container."

printf "\nPortainer installed successfully.\n"