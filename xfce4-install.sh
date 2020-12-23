#!/bin/sh

# Install desktop, icons and theme
sudo pacman --noconfirm -S xfce4 xfce4-goodies
yay --noconfirm -S elementary-xfce-icons-git xfce-theme-greybird-git


# Aplicaciones
sudo pacman --noconfirm -S - < packages/xfce4-apps.txt
yay --noconfirm -S appmenu-gtk-module-git

# Global app menu settings
xfconf-query -c xsettings -p /Gtk/ShellShowsMenuBar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/Modules -n -t string -s "appmenu-gtk-module"

# Appmenu
git clone https://gitlab.com/vala-panel-project/vala-panel-appmenu.git
cd vala-panel-appmenu
mkdir build
meson -Dxfce=enabled -Dbudgie=disabled -Dvalapanel=disabled -Dmate=disabled -Djayatana=disabled build
cd build
sudo ninja && sudo ninja install
cd ../../

# Images
sudo cp *.svg /usr/share/pixmaps

# Session manager
sudo sed -i -e '102 s/#//' /etc/lightdm/lightdm.conf
sudo sed -i -e '102 s/example-gtk-gnome/lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf
sudo rm /etc/lightdm/lightdm-gtk-greeter.conf
sudo mv configurations/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf 

mkdir -p ~/.local/share/plank/themes/Pantheon
cp configurations/plank/dock.theme ~/.local/share/plank/themes/Pantheon

sudo systemctl enable lightdm.service

# Script for change theme
mkdir -p ~/.local/bin
cp scripts/settheme ~/.local/bin
chmod +x ~/.local/bin/settheme

# Delete xfwm4 theme folders
current=$PWD
cd /usr/share/themes
sudo rm -r Agua Adept Alternate AtlantaAtlanta2 B5 B6 Basix BBS Beastie Biz Blackwall Buzz Coldsteel Coolclean Cruxish Curve Daloa Defcon-IV Eazel-blue Elberg Exocet Fbx G2 Galaxy Gaudy Gelly Gnububble Gorilla Gtk Iceg Kde Kde1 Keramik Kindaker Kleanux Kokodi Koynacity Linea LineArt Meenee Metabox Microcurve Microdeck Microdeck2 Microdeck3 Microgui Mofit Moheli Next Ops Opta Oroborus Perl Pills Piranha Platinum Prune Quiet-purple Quinx R9X Redmond RedmondXP Sassandra Silverado Slick Slimline Smallscreen Smoothwall Stoneage Symphony Synthetic Tabs Tgc Tgc-large Therapy Today Totem Trench Tubular TUX Tyrex Variation Wallis Waza Wildbush Xfce Crux Greybird-compact Retro Triviality
cd $current
