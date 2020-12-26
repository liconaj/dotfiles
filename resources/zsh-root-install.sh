#!/bin/bash

# Zsh
bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cp -r ../configurations/zsh/*.zsh-theme /root/.oh-my-zsh/themes
cp -r ../configurations/zsh/zshrc-root /root/.zshrc

