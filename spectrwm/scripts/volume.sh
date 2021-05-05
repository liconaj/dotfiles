#!/bin/sh


ID=5609732

icon(){
    VOL=`pamixer --get-volume`
    muted=`pamixer --get-mute`
    if [[ $muted == true ]]; then
        ICON=volume/muted.svg
    elif [ $VOL -lt 20 ]; then
        ICON=volume/low.svg
    elif [ $VOL -lt 60 ]; then
        ICON=volume/medium.svg
    else
        ICON=volume/high.svg
    fi
    echo  ~/.config/spectrwm/scripts/$ICON
}


up(){
    pamixer -i 5
    VOL=`pamixer --get-volume-human`
    muted=`pamixer --get-mute`
    ICON=$(icon)
    dunstify -I $ICON -u normal -r $ID "${VOL}"
    canberra-gtk-play -i audio-volume-change 
}

down(){
    pamixer -d 5
    VOL=`pamixer --get-volume-human`
    muted=`pamixer --get-mute`
    ICON=$(icon)
    dunstify -I $ICON  -u normal -r $ID "${VOL}"
    canberra-gtk-play -i audio-volume-change
}

toggle_mute(){
    pamixer -t
    muted=`pamixer --get-mute`
    VOL=`pamixer --get-volume-human`
    ICON=$(icon)
    if [[ $muted == true ]]; then
        dunstify -I $ICON -u normal -r $ID "MUTED"
    else
        dunstify -I $ICON -u normal -r $ID "${VOL}"
        canberra-gtk-play -i audio-volume-change
    fi
}

$1
