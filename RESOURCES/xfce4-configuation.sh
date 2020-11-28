#!/bin/sh

# Session options
xfconf-query -c xfce4-session -np /shutdown/ShowHibernate -t bool -s false

# Keyboard layout
xfconf-query -c keyboard-layout -np /Default/XkbLayout -t string -s "latam"

# Thunar configuration
xfconf-query -c thunar -np /last-location-bar -t string -s "ThunarLocationButtons"

# Theme
xfconf-query -c xsettings -np /Net/IconThemeName -t string -s "elementary-xfce-darker"
xfconf-query -c xsettings -np /Net/ThemeName -t string -s "Greybird"
xfconf-query -c xsettings -np /Gtk/FontName -t string -s "Roboto 11"
xfconf-query -c xsettings -np /Gtk/MonospaceFontName -t string -s "Victor Mono Semi-Bold 11"
xfconf-query -c xfwm4 -np /General/theme -t string -s "Greybird"
xfconf-query -c xfwm4 -np /General/title_font -t string -s "Droid Sans Bold 10"

# Shortcuts
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Primary>Print" -t string -s "xfce4-screenshooter"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Primary><Shift>Print" -t string -s "gnome-screenshot -w"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/Print" -t string -s "gnome-screenshot"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Shift>Print" -t string -s "gnome-screenshot -a"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Super>t" -t string -s "xfce4-terminal"

# Whisker menu and terminal configuration
cp -r xfce4/* ~/.config/xfce4/
