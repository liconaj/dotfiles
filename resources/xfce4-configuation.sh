#!/bin/bash

# Session options
xfconf-query -c xfce4-session -np /shutdown/ShowHibernate -t bool -s false

# Theme
xfconf-query -c xsettings -np /Net/IconThemeName -t string -s "elementary-xfce-darker"
xfconf-query -c xsettings -np /Net/ThemeName -t string -s "Greybird"
xfconf-query -c xsettings -np /Gtk/FontName -t string -s "Roboto 11"
xfconf-query -c xsettings -np /Gtk/MonospaceFontName -t string -s "Victor Mono Semi-Bold 11"
xfconf-query -c xfwm4 -np /General/theme -t string -s "Greybird"
xfconf-query -c xfwm4 -np /General/title_font -t string -s "Droid Sans Bold 10"

