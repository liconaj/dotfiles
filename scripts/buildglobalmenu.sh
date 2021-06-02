sudo pacman -S vala bamf meson ninja appmenu-gtk-module cmake libdbusmenu-glib libdbusmenu-gtk3 libdbusmenu-gtk2
meson build \
	-Dxfce=enabled \
	-Dbudgie=disabled \
	-Dvalapanel=disabled \
	-Dmate=disabled \
	-Djayatana=disabled \
	-Dappmenu-gtk-module=enabled


