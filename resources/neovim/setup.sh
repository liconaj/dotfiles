#!/bin/sh

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

yay -S nerd-fonts-victor-mono
sudo pacman -S python-neovim xclip npm nodejs

DATADIR=$HOME/.config/nvim/

[[ ! -d $DATADIR ]] && mkdir -p $DATADIR

cp *.vim $DATADIR
