#!/bin/sh

echo '
[org.gnome.desktop.interface:GNOME-Greeter]
icon-theme="Papirus"
' >> 	/usr/share/glib-2.0/schemas/00_org.gnome.shell.gschema.override

glib-compile-schemas /usr/share/glib-2.0/schemas
