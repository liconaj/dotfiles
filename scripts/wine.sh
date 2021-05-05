#!/bin/bash

sudo pacman -S wine wine-mono winetricks lib32-mpg123 lib32-giflib lib32-libpng lib32-gst-plugins-base lib32-gst-plugins-good 
WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine wineboot
WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks
