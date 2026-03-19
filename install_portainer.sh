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
if docker ps -a --filter "name=^/portainer$" --format "{{.ID}}" >/dev/null; then
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
    portainer/portainer-ce:sts \
  || error "Failed to start Portainer container."

printf "Portainer installed successfully.\n"