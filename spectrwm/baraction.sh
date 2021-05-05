#!/bin/bash


SLEEP_SEC=1

bat(){
    capacity=`acpi -b | awk '{printf("%d", $4)}'`
    state=`acpi -b | awk '{printf("%s"), $3}'`
    if [[ $state == "Charging," ]]; then
        state="(C)"
    else
        state=""
    fi
    echo "BAT: ${capacity}% ${state}"
}

wifi(){
    wifi_state=nmcli dev | grep ^wlp3s0 | awk '{printf ("%s", $3)}'
    echo "$wifi_state"
    if [[ "$wifi_state" == *"conectado"* ]]; then
        QUALITY=`cat /proc/net/wireless | awk '/wlp3s0/ {printf("%s", $3)}' | sed 's/\.//'`
        echo -e "WIFI: ${QUALITY}%"
    fi
}

while :; do
    # echo -e "+@fn=1;ドラム +@fn=0;$(bat)"
    echo -e "$(bat)"
    sleep $SLEEP_SEC
done
