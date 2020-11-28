#!/bin/sh

# Global app menu settings
xfconf-query -c xsettings -p /Gtk/ShellShowsMenuBar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/Modules -n -t string -s "appmenu-gtk-module"

# Session options
xfconf-query -c xfce4-session -np /shutdown/ShowHibernate -t bool -s false

# Keyboard layout
xfconf-query -c keyboard-layout -np /Default/XkbLayout -t string -s "latam"

# Thunar configuration
xfconf-query -c thunar -np /last-location-bar -t string -s "ThunarLocationButtons"

# Theme
xfconf-query -c xsettings -p /Net/IconThemeName -t string -s "elementary-xfce-darker"
xfconf-query -c xsettings -p /Net/ThemeName -t string -s "Greybird"
xfconf-query -c xsettings -p /Gtk/DecorationLayout -t string -s "close,minimze,maximize:menu"
xfconf-query -c xsettings -p /Gtk/FontName -t string -s "Roboto 11"
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -t string -s "Victor Mono Semi-Bold 11"
xfconf-query -c xfwm4 -p /General/theme -t string -s "Greybird"
xfconf-query -c xfwm4 -p /General/title_font -t string -s "Droid Sans Bold 10"
xfconf-query -c xfwm4 -np /General/placement_mode -t string -s "center"
xfconf-query -c xfwm4 -np /General/placement_ratio -t int -s 100

# Shortcuts
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Primary>Print" -t string -s "xfce4-screenshooter"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Primary><Shift>Print" -t string -s "gnome-screenshoot -w"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/Print" -t string -s "gnome-screenshoot"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Shift>Print" -t string -s "gnome-screenshoot -a"
xfconf-query -c "xfce4-keyboard-shortcuts" -np "/commands/custom/<Super>t" -t string -s "xfce4-terminal"

# Whisker menu and terminal configuration
cp -r xfce4/* ~/.config/xfce4/
