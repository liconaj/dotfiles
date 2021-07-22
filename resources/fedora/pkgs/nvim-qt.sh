#!/bin/sh

# dependencies
sudo dnf install cmake qt5-qtbase-devel qt5-qtsvg-devel

cmake -DCMAKE_BUILD_TYPE=Release ..
make
make install

sudo sed -i 's/Neovim-Qt/Neovim Qt/g' /usr/local/share/applications/nvim-qt.desktop
