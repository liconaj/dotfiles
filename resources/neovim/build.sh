#!/bin/sh

sudo pacman -S neovim qt5-svg cmake ninja
current=$PWD

[[ -d build ]] && rm -r build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make

cd $current
