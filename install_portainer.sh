#!/usr/bin/env bash
set -euo pipefail

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
    echo "A container named 'portainer' already exists."
    echo "You can stop and remove first using: docker stop portainer && docker rm portainer"
    exit 1
fi

# Ensure the required ports are free
for p in 8000 9443; do
  if ss -ltn | grep -q ":$p "; then
    error "Port $p is already in use. Free it before running the script."
  fi
done

# Ensure the bridge network 'punte' not exist
if ! docker network inspect punte >/dev/null 2>&1; then
    printf "Creating network 'punte'... "
    docker network create \
        --driver bridge \
        --subnet 172.18.1.0/24 \
        --ip-range 172.18.1.128/25 \
        punte || error "Failed to create network."
    echo "Done."
else
    echo "Network 'punte' already exists."
    exit 1
fi

# Create the volume (idempotent)
docker volume inspect portainer_data >/dev/null 2>&1 \
  || docker volume create portainer_data || error "Failed to create volume."

# Pull the latest image and start the container
docker run -d --pull=always \
    -p 8000:8000 -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    --network=punte --ip 172.18.1.2 \
    portainer/portainer-ce:sts \
  || error "Failed to start Portainer container."

printf "Portainer installed successfully.\n"
