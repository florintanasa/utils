#!/usr/bin/env bash
set -euo pipefail

# Declare some variable
NETname="punte"
IPstatic="172.18.2.2"
#Version="sts" # Short Term Support
Version="latest" # Long Term Support

error() {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

check_internet() {
  printf "Checking internet connectivity... "
  curl -fsI https://github.com >/dev/null || error "Offline. Connect to the internet and retry."
  echo "Online."
}

check_internet

# Identify existing Portainer container and image
container_id=$(docker ps -a --filter "name=portainer" --format "{{.ID}}")
image_name=$(docker ps -a --filter "ancestor=portainer/portainer-ce" --format "{{.Image}}")

if [[ -n $container_id ]]; then
  docker stop "$container_id" 2>/dev/null || echo "Container already stopped."
  docker rm   "$container_id" 2>/dev/null || error "Failed to remove container $container_id"
fi

if [[ -n $image_name ]]; then
  docker rmi "$image_name" 2>/dev/null || echo "Image $image_name not removed (may be in use)."
fi

# Ensure the volume exists
docker volume inspect portainer_data >/dev/null 2>&1 || \
  docker volume create portainer_data || error "Failed to create volume."

docker pull portainer/portainer-ce:"$Version" || error "Failed to pull latest Portainer image."

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

printf "\nPortainer update completed successfully.\n"