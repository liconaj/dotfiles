#!/bin/sh


CONFIG_DIR=$HOME/.config/rx
[[ ! -d $CONFIG_DIR ]] \
	&& echo "Creating $CONFIG_DIR directory..." \
	&& mkdir $CONFIG_DIR

echo "Copying configuration files to $CONFIG_DiR..."
cp -r init.rx $CONFIG_DIR
cp -r pico8.palette $CONFIG_DIR

echo "Installing rx..."
sudo cargo install \
    --git https://github.com/cloudhead/rx \
    --tag v0.4.0 \
    --root /usr/local

echo "Creating desktop entry..."
sudo cp -r rx.desktop /usr/local/share/applications/

echo "Done!"
