#!/bin/sh

SEARCH_DIR=/usr/share/applications
DEST_DIR=$HOME/.local/share/applications
[[ ! -d $DEST_DIR ]] && mkdir -p $DEST_DIR

app=$SEARCH_DIR/$1.desktop
dest_app=$DEST_DIR/$1.desktop

[[ ! -f $dest_app ]] && touch $dest_app
[[ -f $app ]] && cp $app $dest_app

if grep -q "NoDisplay=" $dest_app; then
	grep -i 's/NoDisplay=false/NoDisplay=true' $dest_app
else
	echo NoDisplay=true >> $dest_app
fi
