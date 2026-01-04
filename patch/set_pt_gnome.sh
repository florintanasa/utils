#!/bin/bash
#-
# Copyright (c) 2026 Florin Tanasă <florin.tanasa@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# License GPLv3
#-
# check if is run with root rights
if [ "$(id -u)" != "0" ]; then
  echo "this script must run as root" 1>&2
  exit 1
fi

# Set variables for formating
bold=$(tput bold)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

# Get username
username=$(logname)

# First make backup for dconf files 27-app-folders, 12-extensions-arcmenu and 01-input-sources in the root directory, if not already exist
printf "Make backup for dconf files 27-app-folders, 12-extensions-arcmenu and 01-input-sources in the root directory, if not already exist\n"
if [ ! -f /root/27-app-folders ]; then
  cp /etc/dconf/db/local.d/27-app-folders /root/
fi
if [ ! -f /root/12-extensions-arcmenu ]; then
  cp /etc/dconf/db/local.d/12-extensions-arcmenu /root/
fi
if [ ! -f /root/01-input-sources ]; then
  cp /etc/dconf/db/local.d/01-input-sources /root/
fi

# Modify for Portuguese language in central/system dconf (for new user)
sed -i "s/name='Themes settings'/name='Configurações de temas'/g" /etc/dconf/db/local.d/27-app-folders
sed -i "s/name='Office'/name='Escritório'/g" /etc/dconf/db/local.d/27-app-folders
sed -i "s/name='Graphics'/name='Gráficos'/g" /etc/dconf/db/local.d/27-app-folders
sed -i "s/name='Programming'/name='Programação'/g" /etc/dconf/db/local.d/27-app-folders
sed -i "s/name='Accessories'/name='Acessórios'/g" /etc/dconf/db/local.d/27-app-folders
sed -i "s/'name': 'Programming'/'name': 'Programação'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/'name': 'System'/'name': 'Sistema'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/'name': 'Office'/'name': 'Escritório'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/'name': 'Graphics'/'name': 'Gráficos'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/'name': 'Accessories'/'name': 'Acessórios'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/'name': 'Themes settings'/'name': 'Configurações de temas'/g" /etc/dconf/db/local.d/12-extensions-arcmenu
sed -i "s/sources=\[('xkb', 'us'), ('xkb', 'ro')]\s*/sources=[('xkb', 'br'), ('xkb', 'us')]/g"  /etc/dconf/db/local.d/01-input-sources

# Modify for Portuguese language in dconf (for actual user)
# Generate dconf.ini file
printf "Generate dconf.ini file\n"
sudo -u $username dconf dump / > dconf.ini

# Make backup for dconf.ini
printf "Make backup for dconf.ini into dconf.bak file\n"
sudo -u $username cp dconf.ini dconf.bak
# Now modify in dconf.ini file groups programming name for Portuguese language
printf "Now modify in dconf.ini file groups programming name for Portuguese language\n"
sudo -u $username sed -i "s/name='Themes settings'/name='Configurações de temas'/g" dconf.ini
sudo -u $username sed -i "s/name='Office'/name='Escritório'/g" dconf.ini
sudo -u $username sed -i "s/name='Graphics'/name='Gráficos'/g" dconf.ini
sudo -u $username sed -i "s/name='Programming'/name='Programação'/g" dconf.ini
sudo -u $username sed -i "s/name='Accessories'/name='Acessórios'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'Programming'/'name': 'Programação'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'System'/'name': 'Sistema'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'Office'/'name': 'Escritório'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'Graphics'/'name': 'Gráficos'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'Accessories'/'name': 'Acessórios'/g" dconf.ini
sudo -u $username sed -i "s/'name': 'Themes settings'/'name': 'Configurações de temas'/g" dconf.ini
sudo -u $username sed -i "s/sources=\[('xkb', 'us'), ('xkb', 'ro')]\s*/sources=[('xkb', 'br'), ('xkb', 'us')]/g" dconf.ini

# Load modified configs from dconf.ini file
printf "Load modified configs from dconf.ini file\n\n"
sudo -u $username bash -c 'pid=$(pgrep -u $USER -n gnome-shell);
addr=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | cut -d= -f2- | tr -d "\0");
export DBUS_SESSION_BUS_ADDRESS=$addr;
dconf load / < dconf.ini'

# Final messages
printf "${bold}${cyan}Finish and thanks for usage${reset}\n\n\n"
printf "If is not ok, the old configs can be loaded using 'dconf load / < dconf.bak\n"
printf "Also you have a backup files for 27-app-folders, 12-extensions-arcmenu and 01-input-sources in the /root directory,\n"
printf "this can be put back in /etc/dconf/db/local.d/ directory, but only if the patch is not applied correctly in your case\n"

