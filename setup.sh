#!/bin/bash

current=$PWD

# Install yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si
cd $current

## Repositories
sudo sed -i -e  '92,93 s/\#//' /etc/pacman.conf
sudo cp -r configurations/pacman.conf /etc/pacman.conf && sudo pacman  -Syyy

# Xorg and fonts
sudo pacman --noconfirm  -S - < packages/xorg.txt
sudo pacman --noconfirm  -Rs xorg-fonts-75dpi xorg-fonts-100dpi

mkdir -p ~/.config/fontconfig
cp -r configurations/fonts/fonts.conf ~/.config/fontconfig
cp -r configurations/fonts/.Xresources ~/.Xresources
cp -r configurations/fonts/.xsettingsd ~/.xsettingsd

sudo pacman --noconfirm  -S - < packages/fonts.txt
yay --noconfirm -S - < packages/aur-fonts.txt

# Replace ls with exa
yay --noconfirm -S exa


# Install libreoffice
sudo pacman --noconfirm -S - < packages/libreoffice.txt

# Install some AUR-applications
yay --noconfirm -S - < packages/aurs.txt


# Install some applications
sudo pacman --noconfirm -S - < packages/generals.txt

# Some folders
mkdir  ~/Aplicaciones
echo Aplicaciones > ~/.hidden

# Games
pip install pygame
sudo pacman --noconfirm -S sdl_image sdl_ttf
sudo pacman --noconfirm -S lib32-sdl_image lib32-sdl_ttf

# Some python packages
pip install jedi autopep8 flake8 ipython yapf

# Autoremove scrip for orphan pkgs
cp -r scripts/autoremove ~/.local/bin
chmod +x ~/.local/bin/autoremove

# Archey 4
cp -r configurations/archey4 ~/.config

# Swappiness
sudo cp -r configurations/99-swappiness.conf /etc/sysctl.d/

# Backgrounds
sudo cp -r backgrounds/* /usr/share/backgrounds/

echo ""
echo OK
