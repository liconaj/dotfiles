#!/bin/sh

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
bash install.sh
cd ..
rm -rf fonts
