#!/bin/sh

sudo pacman -S mpd
sudo usermod -G josue --append mpd
sudo usermod -G audio --append mpd
