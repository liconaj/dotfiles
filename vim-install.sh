#!/bin/sh

cp configurations/vimrc ~/.vimrc
sudo cp configurations/vimrc-root /root/.vimrc
sudo mkdir -p /root/.vim/files/backup
sudo mkdir -p /root/.vim/files/undo
mkdir -p ~/.vim/files/backup
mkdir -p ~/.vim/files/undo

