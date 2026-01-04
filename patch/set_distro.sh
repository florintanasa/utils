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
# check if is run as root
if [ "$(id -u)" != "0" ]; then
  echo "this script must run as root" 1>&2
  exit 1
fi
# set variable
os_release="/usr/lib/os-release"
lsb_release="/usr/bin/lsb_release"
# First backup file
cp /usr/lib/os-release /usr/lib/os-release.bak
cp /usr/bin/lsb_release /usr/bin/lsb_release.bak
# Second apply modification
sed -i 's/NAME="Void"/NAME="BRGV-OS"/g' "$os_release"
sed -i 's/PRETTY_NAME="Void Linux"/PRETTY_NAME="BRGV-OS Linux"/g' "$os_release"
sed -i 's/HOME_URL=\"https:\/\/voidlinux.org\/\"/HOME_URL=\"https:\/\/github.com\/florintanasa\/brgvos-void\"/g' "$os_release"
sed -i 's/LOGO="void-logo"/LOGO="brgvos-logo"/g' "$os_release"
sed -i 's/description="Void Linux"/description="BRGV-OS Linux"/g' "$lsb_release"
