#!/bin/bash -e
echo "Creating /opt/lexaloffle/ ..."
sudo mkdir -p /opt/lexaloffle/

[[ -d /opt/lexaloffle/pico-8 ]] && echo "Removing old installation..." && sudo rm -r /opt/lexaloffle/pico-8

echo "Copying pico-8 folder into /opt/lexaloffle/ ..."
sudo cp -r pico-8 /opt/lexaloffle/

echo "Creating .desktop file..."
echo "[Desktop Entry]
Type=Application
Name=PICO-8
GenericName=Fantasy Console
Comment=Lexaloffle's fantasy console
Exec=/opt/lexaloffle/pico-8/pico8
Icon=pico-8
Categories=GTK;Development;Game Development;
StartupNotify=true
Keywords=pico8;pico;pico-8;lexaloffle;gamedev;
StartupWMClass=pico8
" > pico-8.desktop

[[ ! -d /usr/local/share/applications ]] && sudo mkdir /usr/local/share/applications

sudo mv pico-8.desktop /usr/local/share/applications/pico-8.desktop
#sudo mv /opt/lexaloffle/pico-8/pico8 /opt/lexaloffle/pico-8/PICO-8

echo "Pico-8 Installed on /opt/lexaloffle/pico-8/"
