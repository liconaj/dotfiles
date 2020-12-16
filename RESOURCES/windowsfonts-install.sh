#!/bin/bash

echo "Instalación fuentes de Windows"
echo "1. Solo este usuario"
echo "2. Todos los usuarios"
read -p "Ingresar opción [1]: " opcion
if [ opcion == "2" ]; then
	sudo cp -r WindowsFonts /usr/share/fonts/WindowsFonts
else
	if [ ! -d "$HOME/.fonts" ]; then
		mkdir ~/.fonts
	fi
	cp -r WindowsFonts ~/.fonts
fi

echo
echo "OK"
