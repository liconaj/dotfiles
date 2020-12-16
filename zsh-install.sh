#!/bin/bash

# Zsh
sudo pacman -S zsh
bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp -r configurations/zsh/*.zsh-theme ~/.oh-my-zsh/themes
cp -r configurations/zsh/zshrc ~/.zshrc
cp -r configurations/profile ~/.profile
