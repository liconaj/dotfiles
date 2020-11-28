#!/bin/bash

## Install yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg -si && cd ~

## Repositories
sudo sed -i -e  '92,93 s/\#//' /etc/pacman.conf
sudo cp -r configurations/pacman.conf /etc/pacman.conf && sudo pacman -Syyy

# Xorg and fonts
sudo pacman -S - < packages/xorg.txt
sudo pacman -Rs xorg-fonts-75dpi xorg-fonts-100dpi

mkdir -p ~/.config/fontconfig
cp configurations/fonts/fonts.conf ~/.config/fontconfig
cp configurations/fonts/.Xresources ~/.Xresources
cp configurations/fonts/.xsettingsd ~/.xsettingsd

sudo pacman -S - < packages/fonts.txt
yay -S - < packages/aur-fonts.txt

# Replace ls with exa
yay -S exa

# Zsh
sudo pacman -S zsh
bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp configurations/zsh/custom-simple.zsh-theme ~/.oh-my-zsh/themes
cp configurations/zsh/zshrc ~/.zshrc
cp configurations/profile ~/.profile

# Install Xfce4
sh xfce4-install.sh

# Install libreoffice
sudo pacman -S - < packages/libreoffice.txt

# Install some AUR-applications
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8FD3D9A8D3800305A9FFF259D1742AD60D811D58
yay -S packages/aurs.txt


# Install some applications
sudo pacman -S - < packages/generals.txt

# Snap
sudo pacman -S packagekit
sudo systemctl enable --now apparmor.service
sudo systemctl enable --now snapd.apparmor.service
sudo systemctl enable snapd.socket

# Some folders
mkdir  ~/Aplicaciones
echo Aplicaciones > ~/.hidden
echo snap >> ~/.hidden

fc-cache -fv

# Games
pip install pygame
sudo pacman -S sdl_image sdl_ttf
sudo pacman -S lib32-sdl_image lib32-sdl_ttf


# Window directory
ln -sf /windows/Users/licona ~/Windows
ln -sf /windows/Users/licona/Documents  ~/Documentos/Mis\ documentos
ln -sf /windows/Users/licona/Downloads  ~/Descargas/Mis\ descargas
ln -sf /windows/Users/licona/Pictures/*  ~/Imágenes/
ln -sf /windows/Users/licona/Music/*  ~/Música/

# Autoremove scrip for orphan pkgs
cp scripts/autoremove ~/.local/bin
chmod +x ~/local/bin/autoremove

# Archey 4
cp -r configurations/archey4 ~/.config

# Swappiness
sudo cp configurations/99-swappiness.conf /etc/sysctl.d/

# Backgrounds
sudo cp backgrounds/* /usr/share/backgrounds/

# Wine
winetricks settings fontsmooth=rgb

# Vim installation
bash vim-install.sh
 
echo ""
echo OK
