#!/bin/sh

sudo pacman -S libcanberra
xfconf-query -c xsettings -np /Net/SoundThemeName -t string -s "Default"
xfconf-query -c xsettings -np /Net/EnableEventSounds -t bool -s "true"
xfconf-query -c xsettings -np /Net/EnableInputFeedbackSounds -t bool -s "true"
