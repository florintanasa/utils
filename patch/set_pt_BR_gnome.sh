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

# Set variables for text formating
bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yeallow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

# Set some variables
app_folders="/etc/dconf/db/local.d/27-app-folders"
extensions_arcmenu="/etc/dconf/db/local.d/12-extensions-arcmenu"
input_sources="/etc/dconf/db/local.d/01-input-sources"

# Get username
username=$(logname)

function display_help() {
  echo -e "${bold}${cyan}Usage:${reset}"
  echo -e "  ./set_pt_BR_gnome.sh [PARAMETER]"
  echo -e "\n${bold}${cyan}Description:${reset}"
  echo -e "  This script add modify for Portuguese language, from English to Portuguese, in dconf for all new users and/or actual user"
  echo -e "  Also, set as keyboard 'br' and install some localized packages xbps"
  echo -e "  If a the user provide an ARGUMENT, like '1' or '2' or '1 2' this script is run directly"
  echo -e "  If a the user not provide an ARGUMENT apear a menu with some options."
  echo -e "\n${bold}${cyan}Options${reset}:"
  echo -e "     ${magenta}With PARAMETER\tModify for Portuguese language, for all new user or actual user.${reset}"
  echo -e "  ${yeallow}Without PARAMETER\tIs open a options menu with next options:${reset}"
  echo -e "  ${blue}Option 1 - Modify for Portuguese language, from English to Portuguese, in dconf for${reset}"
  echo -e "             ${blue}all new users, add 'br' keyboard and add additional packages for localized language.${reset}"
  echo -e "  ${blue}Option 2 - Modify for Portuguese language, from English to Portuguese, in dconf for${reset}"
  echo -e "             ${blue}current user, add 'br' keyboard and add additional packages for localized language.${reset}"
  echo -e "  ${blue}Option 3 - Modify for Portuguese language, from English to Portuguese, in dconf for${reset}"
  echo -e "             ${blue}all new users and current user, add 'br' keyboard and add additional packages for localized language.${reset}"
  echo -e "  ${blue}Option 4 - Modify for English language, from Portuguese to English, in dconf for${reset}"
  echo -e "             ${blue}all new users, set 'us' default keyboard and 'br' secondary keybord.${reset}"
  echo -e "  ${blue}Option 5 - Modify for English language, from Portuguese to English, in dconf for${reset}"
  echo -e "             ${blue}current user, set 'us' default keyboard and 'br' secondary keybord.${reset}"
  echo -e "  ${blue}Option 6 - Modify for English language, from Portuguese to English, in dconf for${reset}"
  echo -e "             ${blue}all new users and current user, set 'us' default keyboard and 'br' secondary keybord.${reset}"
  echo -e "  ${red}Option 7 - Exit from script.${reset}"
  echo -e "\n${bold}${cyan}Examples:${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 1${reset}\t\t${blue}# Option 1${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 2\t${reset}\t${blue}# Option 2${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 1 2${reset}\t\t${blue}# Option 3${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 2 1${reset}\t\t${blue}# Option 3${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 3${reset}\t\t${blue}# Option 4${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 4\t${reset}\t${blue}# Option 5${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 3 4${reset}\t\t${blue}# Option 6${reset}"
  echo -e "  ${magenta}./set_pt_BR_gnome.sh 4 3${reset}\t\t${blue}# Option 6${reset}"
  echo -e "  ${yeallow}./set_pt_BR_gnome.sh$\t\t\t# Use the menu to choose an option${reset}"
  echo -e "  ./set_pt_BR_gnome.sh --help or -h \t# This help."
  exit 0
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  display_help
fi

# Modify for Portuguese language in central/system dconf (for all new user)
set_for_all_users_BR_EN() {
  # First make backup for dconf files 27-app-folders, 12-extensions-arcmenu and 01-input-sources in the root directory,
  # if not already exist
  printf "Make backup of dconf files '27-app-folders', '12-extensions-arcmenu', and '01-input-sources'
in the '/root/backup' directory, if they do not already exist\n"
  if [ ! -d /root/backup ]; then # check if directrory not exist, if not make directory backup on /root
    mkdir -p /root/backup
  fi
  if [ ! -f /root/backup/27-app-folders ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$app_folders" /root/backup
  fi
  if [ ! -f /root/backup/12-extensions-arcmenu ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$extensions_arcmenu" /root/backup
  fi
  if [ ! -f /root/backup/01-input-sources ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$input_sources" /root/backup
  fi

  # Modify for Portuguese language in central/system dconf (for new user)
  sed -i "s/name='Themes settings'/name='Configurações de temas'/g" "$app_folders"
  sed -i "s/name='Office'/name='Escritório'/g" "$app_folders"
  sed -i "s/name='Graphics'/name='Gráficos'/g" "$app_folders"
  sed -i "s/name='Programming'/name='Programação'/g" "$app_folders"
  sed -i "s/name='Accessories'/name='Acessórios'/g" "$app_folders"
  sed -i "s/'name': 'Programming'/'name': 'Programação'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'System'/'name': 'Sistema'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Office'/'name': 'Escritório'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Graphics'/'name': 'Gráficos'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Accessories'/'name': 'Acessórios'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Themes settings'/'name': 'Configurações de temas'/g" "$extensions_arcmenu"
  sed -i "s/sources=\[('xkb', 'us'), ('xkb', 'ro')]\s*/sources=[('xkb', 'br'), ('xkb', 'us')]/g" "$input_sources"

  # Update dconf database
  printf "Update dconf database\n"
  dconf update
}

# Modify for Portuguese language in dconf (for actual user)
set_for_current_user_BR_EN() {
  # Generate dconf.ini file
  printf "Generate dconf.ini file\n"
  sudo -u "$username" mkdir -p /home/"$username"/backup
  dconf_file="/home/$username/backup/dconf.ini"
  sudo -u "$username" dconf dump / >"$dconf_file"

  # Make backup for dconf.ini
  printf "Make backup of 'dconf.ini' into 'dconf.bak' file\n"
  sudo -u "$username" cp /home/"$username"/backup/dconf.ini /home/"$username"/backup/dconf.bak

  # Now modify in dconf.ini file groups programming name for Portuguese language
  printf "Now modify the group names for app in dconf.ini file for Portuguese language\n"
  sudo -u "$username" sed -i "s/name='Themes settings'/name='Configurações de temas'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Office'/name='Escritório'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Graphics'/name='Gráficos'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Programming'/name='Programação'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Accessories'/name='Acessórios'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Programming'/'name': 'Programação'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'System'/'name': 'Sistema'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Office'/'name': 'Escritório'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Graphics'/'name': 'Gráficos'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Accessories'/'name': 'Acessórios'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Themes settings'/'name': 'Configurações de temas'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/sources=\[('xkb', 'us'), ('xkb', 'ro')]\s*/sources=[('xkb', 'br'), ('xkb', 'us')]/g" "$dconf_file"

  # Load modified configs from dconf.ini file
  printf "Load modified configs from dconf.ini file\n\n"
  sudo -u "$username" bash -c "pid=\$(pgrep -u \$USER -n gnome-shell);
addr=\$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/\$pid/environ | cut -d= -f2- | tr -d '\0');
export DBUS_SESSION_BUS_ADDRESS=\$addr;
dconf load / < \"$dconf_file\""
}

# Modify for English language for all new user
set_for_all_users_EN_BR() {
  # First make backup for dconf files 27-app-folders, 12-extensions-arcmenu and 01-input-sources in the root directory,
  # if not already exist
  printf "Make backup of dconf files '27-app-folders', '12-extensions-arcmenu', and '01-input-sources'
in the '/root/backup' directory, if they do not already exist\n"
  if [ ! -d /root/backup ]; then # check if directrory not exist, if not make directory backup on /root
    mkdir -p /root/backup
  fi
  if [ ! -f /root/backup/27-app-folders ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$app_folders" /root/backup
  fi
  if [ ! -f /root/backup/12-extensions-arcmenu ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$extensions_arcmenu" /root/backup
  fi
  if [ ! -f /root/backup/01-input-sources ]; then # check if the file not exist, if exist do nothing, else copy from system in /root/backup
    cp "$input_sources" /root/backup
  fi

  # Modify for English language in dconf for all new users
  sed -i "s/name='Configurações de temas'/name='Themes settings'/g" "$app_folders"
  sed -i "s/name='Escritório'/name='Office'/g" "$app_folders"
  sed -i "s/name='Gráficos'/name='Graphics'/g" "$app_folders"
  sed -i "s/name='Programação'/name='Programming'/g" "$app_folders"
  sed -i "s/name='Acessórios'/name='Accessories'/g" "$app_folders"
  sed -i "s/'name': 'Programação'/'name': 'Programming'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Sistema'/'name': 'System'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Escritório'/'name': 'Office'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Gráficos'/'name': 'Graphics'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Acessórios'/'name': 'Accessories'/g" "$extensions_arcmenu"
  sed -i "s/'name': 'Configurações de temas'/'name': 'Themes settings'/g" "$extensions_arcmenu"
  sed -i "s/sources=\[('xkb', 'br'), ('xkb', 'us')]\s*/sources=[('xkb', 'us'), ('xkb', 'br')]/g" "$input_sources"

  # Update dconf database
  printf "Update dconf database\n"
  dconf update
}

# Modify for Portuguese language in dconf (for actual user)
set_for_current_user_EN_BR() {
  # Generate dconf.ini file
  printf "Generate dconf.ini file\n"
  sudo -u "$username" mkdir -p /home/"$username"/backup
  dconf_file="/home/$username/backup/dconf.ini"
  sudo -u "$username" dconf dump / >"$dconf_file"

  # Make backup for dconf.ini
  printf "Make backup of 'dconf.ini' into 'dconf.bak' file\n"
  sudo -u "$username" cp /home/"$username"/backup/dconf.ini /home/"$username"/backup/dconf.bak

  # Now modify in dconf.ini file groups programming name for English language
  printf "Now modify the group names for app in dconf.ini file for English language\n"
  sudo -u "$username" sed -i "s/name='Configurações de temas'/name='Themes settings'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Escritório'/name='Office'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Gráficos'/name='Graphics'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Programação'/name='Programming'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/name='Acessórios'/name='Accessories'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Programação'/'name': 'Programming'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Sistema'/'name': 'System'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Escritório'/'name': 'Office'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Gráficos'/'name': 'Graphics'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Acessórios'/'name': 'Accessories'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/'name': 'Configurações de temas'/'name': 'Themes settings'/g" "$dconf_file"
  sudo -u "$username" sed -i "s/sources=\[('xkb', 'br'), ('xkb', 'us')]\s*/sources=[('xkb', 'us'), ('xkb', 'br')]/g" "$dconf_file"

  # Load modified configs from dconf.ini file
  printf "Load modified configs from dconf.ini file\n\n"
  sudo -u "$username" bash -c "pid=\$(pgrep -u \$USER -n gnome-shell);
addr=\$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/\$pid/environ | cut -d= -f2- | tr -d '\0');
export DBUS_SESSION_BUS_ADDRESS=\$addr;
dconf load / < \"$dconf_file\""
}

set_localize_packages() {
  # Add other packages for Portuguese language
  printf "Install other packages for Portuguese (Brazil) language\n\n"
  xbps-install -Sy firefox-i18n-pt-BR libreoffice-i18n-pt-BR mythes-pt_BR hyphen-pt_BR manpages-pt-br hunspell-pt_BR
}

# Final messages 1
final_message_1() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, you have a backup files for '27-app-folders', '12-extensions-arcmenu' , and '01-input-sources' in the '/root/backup' directory.
These files can be put back in then '/etc/dconf/db/local.d/' directory, and then run 'sudo dconf update', but only if the patch is not applied correctly in your case.
It is a good idea to archive these files or/and to put it in another safe place.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$reset"
}

# Final messages 2
final_message_2() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, the old configs can be loaded using 'dconf load / < /home/%s/backup/dconf.bak', but only if the patch is not applied correctly in your case.
It is a good idea to archive 'dconf.bak' or to put it in another safe place, because if you run once again this script, the file is overwritten.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$username" "$reset"
}

# Final messages 3
final_message_3() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, the old configs can be loaded using 'dconf load / < /home/%s/backup/dconf.bak'.
Also, you have a backup files for '27-app-folders', '12-extensions-arcmenu' , and '01-input-sources' in the '/root/backup' directory.
These files can be put back in then '/etc/dconf/db/local.d/' directory, and then run 'sudo dconf update', but only if the patch is not applied correctly in your case.
It is a good idea to archive 'dconf.bak' or to put it in another safe place, because if you run once again this script, the file is overwritten.
Also, is a good idea to archive the files from '/root/backup' or/and to put it in another safe place.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$username" "$reset"
}

# Final messages 4
final_message_4() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, you have a backup files for '27-app-folders', '12-extensions-arcmenu' , and '01-input-sources' in the '/root/backup' directory.
These files can be put back in then '/etc/dconf/db/local.d/' directory, and then run 'sudo dconf update', but only if the patch is not applied correctly in your case.
It is a good idea to archive these files or/and to put it in another safe place.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$reset"
}

# Final messages 5
final_message_5() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, the old configs can be loaded using 'dconf load / < /home/%s/backup/dconf.bak', but only if the patch is not applied correctly in your case.
It is a good idea to archive 'dconf.bak' or to put it in another safe place, because if you run once again this script, the file is overwritten.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$username" "$reset"
}

# Final messages 6
final_message_6() {
  printf "\n\n%s%sFinish and thanks for usage%s\n\n
%sRead carefully:%s
%sIf is not OK, the old configs can be loaded using 'dconf load / < /home/%s/backup/dconf.bak'.
Also, you have a backup files for '27-app-folders', '12-extensions-arcmenu' , and '01-input-sources' in the '/root/backup' directory.
These files can be put back in then '/etc/dconf/db/local.d/' directory, and then run 'sudo dconf update', but only if the patch is not applied correctly in your case.
It is a good idea to archive 'dconf.bak' or to put it in another safe place, because if you run once again this script, the file is overwritten.
Also, is a good idea to archive the files from '/root/backup' or/and to put it in another safe place.%s\n" \
    "$bold" "$cyan" "$reset" "$red" "$reset" "$green" "$username" "$reset"
}

# Check if was sent a parameter
if [ $# -eq 0 ]; then
  echo "${blue}Please select an option from menu:${reset}"

  select opt in "EN->BR for the all new users" "EN->BR for the current user" "EN->BR for all new users and the current user" \
    "BR->EN for the all new users" "BR->EN for the current user" "BR->EN for all new users and the current user" \
    "Exit"; do
    case $opt in
    "EN->BR for the all new users")
      echo "${blue}You choose - Modify for Portuguese language in dconf for all new users.${reset}"
      set_for_all_users_BR_EN
      set_localize_packages
      final_message_1
      break
      ;;
    "EN->BR for the current user")
      echo "${blue}You choose - Modify for Portuguese language in dconf for the current user.${reset}"
      set_for_current_user_BR_EN
      set_localize_packages
      final_message_2
      break
      ;;
    "EN->BR for all new users and the current user")
      echo "${blue}You choose - Modify for Portuguese language in dconf for all new users and the current user.${reset}"
      set_for_all_users_BR_EN
      set_for_current_user_BR_EN
      set_localize_packages
      final_message_3
      break
      ;;
    "BR->EN for the all new users")
      echo "${blue}You choose - Modify for English language in dconf for all new users.${reset}"
      set_for_all_users_EN_BR
      # localized packages remain because can exist another user what need these
      final_message_4
      break
      ;;
    "BR->EN for the current user")
      echo "${blue}You choose - Modify for English language in dconf for the current user.${reset}"
      set_for_current_user_EN_BR
      # localized packages remain because can exist another user what need these
      final_message_5
      break
      ;;
    "BR->EN for all new users and the current user")
      echo "${blue}You choose - Modify for English language in dconf for all new users and the current user.${reset}"
      set_for_all_users_EN_BR
      set_for_current_user_EN_BR
      # localized packages remain because can exist another user what need these
      final_message_6
      break
      ;;
    "Exit")
      echo "Exit from menu."
      break
      ;;
    *)
      echo "${red}Invalid option, please try once again.${reset}"
      ;;
    esac
  done
else
  # If a parameter was send is executed directly
  if [[ "$1" == "1" && "$2" == "2" ]] || [[ "$1" == "2" && "$2" == "1" ]]; then
    echo "${blue}You choose - Modify for Portuguese language in dconf for all new users and the current user.${reset}"
    set_for_all_users_BR_EN
    set_for_current_user_BR_EN
    set_localize_packages
  elif [ "$1" == "1" ]; then
    echo "${blue}You choose - Modify for Portuguese language in dconf for all new users.${reset}"
    set_for_all_users_BR_EN
    set_localize_packages
  elif [ "$1" == "2" ]; then
    echo "${blue}You choose - Modify for Portuguese language in dconf for the current user.${reset}"
    set_for_current_user_BR_EN
    set_localize_packages
  elif [[ "$1" == "3" && "$2" == "4" ]] || [[ "$1" == "4" && "$2" == "3" ]]; then
    echo "${blue}You choose - Modify for English language in dconf for all new users and the current user.${reset}"
    set_for_all_users_EN_BR
    set_for_current_user_EN_BR
    # localized packages remain because can exist other users what need these
  elif [ "$1" == "3" ]; then
    echo "${blue}You choose - Modify for English language in dconf for all new users.${reset}"
    set_for_all_users_EN_BR
    # localized packages remain because can exist other users what need these
  elif [ "$1" == "4" ]; then
    echo "${blue}You choose - Modify for English language in dconf for the current user.${reset}"
    set_for_current_user_EN_BR
    # localized packages remain because can exist other users what need these
  else
    echo -e "${red}Invalid parameter. Please use for parameters numbers:\n
    '1' to Modify for Portuguese language in system dconf, for all new users;
    '2' to Modify for Portuguese language in dconf, for the current user;
    '1' '2' or '2' '1' to Modify for Portuguese language in system dconf, for all new users and for current user;\n
    '3' to Modify for English language in system dconf, for all new users;
    '4' to Modify for English language in dconf, for the current user;
    '3' '4' or '2' '1' to Modify for English language in system dconf, for all new users and for current user;\n
    Run './set_pt_BR_gnome.sh --help or -h for more help.'${reset}"
  fi
fi
