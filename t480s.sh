#!/bin/bash

# Name: T480s tuning system
# Authors: Marcílio Nascimento <marcilio.mcn at gmail.com>
# First Release: 2020, February
# Description: Tuning commands for ThinkPad T480s on Void Linux
# License: MIT
# Version: 202002.01

# Declare constants and variables
# UPDATETYPE='-Sy' # If GenuineIntel update local repository, change the next one to only '-y'
PKG_LIST=''

# Detect if we're on Intel system
CPU_VENDOR=$(grep vendor_id /proc/cpuinfo | uniq | awk '{print $3}')

# If GenuineIntel, install void-repo-nonfree, add package for this architecture in $PKG_LIST 
# and update the xbps-install type for installation
if [ $CPU_VENDOR == 'GenuineIntel' ]; then
  # clear
  echo ''
  echo 'Detected GenuineIntel Arch. Adding new repo and Package to install.'
  xbps-install $UPDATETYPE -R ${REPO}/current/musl void-repo-nonfree
  PKG_LIST+='intel-ucode '
  UPDATETYPE='-y'
fi