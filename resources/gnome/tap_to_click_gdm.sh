#!/bin/sh

#switch to gdm user
su - gdm -s /bin/sh 
export $(dbus-launch)
GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false"
