#!/bin/sh

cp configurations/vim/vimrc ~/.vimrc
sudo cp configurations/vim/vimrc-root /root/.vimrc
sudo mkdir -p /root/.vim/files/backup
sudo mkdir -p /root/.vim/files/undo
mkdir -p ~/.vim/files/backup
mkdir -p ~/.vim/files/undo

