#!/usr/bin/env bash

sudo pacman -S libcanberra libcanberra-pulse
xfconf-query -c xsettings -np /Net/SoundThemeName -t string -s "Default"

# TODO:
# Habilitar eventos de sonidos en Configuración de Apariencia
# Habilitar sonidos del sistema en pavucontrol

# WhiteSur theme
sudo pacman -S gtk-engine-murrine gtk-engines
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git WhiteSur
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git WhiteSur-icons
WhiteSur/install.sh
WhiteSur-icons/install.sh

