#!/bin/sh

CONFIGDIR=$HOME/.config/mpd
[[ ! -d $CONFIGDIR ]]  && mkdir -p $CONFIGDIR
cp mpd.conf $CONFIGDIR
touch $CONFIGDIR/mpdstate
touch $CONFIGDIR/mpd.pid
touch $CONFIGDIR/mpd.log
touch $CONFIGDIR/mpd.db
mkdir $CONFIGDIR/playlists

#AUTOSTART=$HOME/.config/autostart
#[[ ! -d $AUTOSTART ]] && mkdir $AUTOSTART
#cp MPD.desktop $AUTOSTART
#
#if ! command -v mpd &> /dev/null; then
#    sudo pacman -S mpd
#fi

systemctl --user enable mpd.socket

sudo gpasswd -a $USER mpd
#sudo gpasswd -a mpd $USER
#sudo gpasswd -a $USER audio
#sudo gpasswd -a mpd audio
