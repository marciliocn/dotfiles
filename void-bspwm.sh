#!/bin/bash

# Exit immediately if a command exits with a non-zero exit status
set -e

clear
echo ''
echo '############################################'
echo '######## Dotfiles Installer - BSPWM ########'
echo '############################################'

# Declare constants and variables
# UPDATETYPE='-Sy' # If GenuineIntel update local repository, change the next one to only '-y'

# Settings
PKG_LIST='xorg-minimal terminus-font freefont-ttf xset alsa-utils bspwm sxhkd st'
FIREWALL=0 # 1=Install, 0=Do not install (install only if running some server daemon)

# If Firewall is 1
[ $FIREWALL ] && PKG_LIST+=' ufw'

# Install packages
sudo xbps-install -y $PKG_LIST

# Configure bspwm and sxhkd start (disable after customize dotfiles for bspwm and sxhkd)
mkdir -p ~/.config/{bspwm,sxhkd}
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd
chmod +x ~/.config/bspwm/bspwmrc
sed 's/urxvt/st/' < ~/.config/sxhkd/sxhkdrc
echo 'exec bspwm' > ~/.xinitrc
# Configure bspwm and sxhkd end

# Configure Firewall if 1
if [ $FIREWALL ]; then
	sudo xbps-reconfigure ufw
	sudo ufw enable
	sudo ln -s /etc/sv/ufw /var/service
fi

clear
echo ''
echo '############################################################'
echo '######## Dotfiles for BSPWM Installed Successfully! ########'
echo '############################################################'