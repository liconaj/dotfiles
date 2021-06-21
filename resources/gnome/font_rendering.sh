#!/bin/sh

SCHEMAS_DIR=/usr/share/glib-2.0/schemas
sed -i "s/>'grayscale'</>'rgba'</g" $SCHEMAS_DIR/org.gnome.settings-daemon.plugins.xsettings.gschema.xml

glib-compile-schemas $SCHEMAS_DIR
