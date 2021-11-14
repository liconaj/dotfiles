##!/bin/bash
clear
echo " *** SCRIPT CPU-FREQ SCALING  *** "
echo " SELECCIONA UNA OPCIÓN. "
echo " 0.-Frecuencia actual del procesador"
echo " 1.-Powersave"
echo " 2.-Schedutil"
echo " 3.-Ondemand----(Recomendado para AMD)"
echo " 4.-Performance"
echo " 5.-Conservative"
echo " 6.-Userspace----(Asigna una frecuencia de forma manual)"
echo " 7.-¿Qué frecuencia tengo?"
echo " 8.-CPU frequency-info---(Ver frecuencias a las que se puede alcanzar"
echo "****************************************"
echo " 9.-Cambiar de forma permanente governor"
echo "*****************************************" 
echo " 10.-Salir"
echo ""
read -p "OPCIÓN: " OPCIÓN
case $OPCION in
0) watch grep \"cpu MHz\" /proc/cpuinfo;;
1) sudo cpupower frequency-set  -r -g powersave;;
2) sudo cpupower frequency-set  -r -g schedutil;;
3) sudo cpupower frequency-set  -r -g ondemand;;
4) sudo cpupower frequency-set  -r -g performance;;
5) sudo cpupower frequency-ser  -r -g conservative;;
6) echo -n " *** Ingresa de forma manual la frecuencia *** "
read freq
sudo cpupower frequency-set -f $freq;;
7) echo "**** Frecuencia actual ****: "
echo "****************************** "
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ;;
8) cpupower frequency-info ;;
9) sudoedit /etc/default/cpupower ;;
10) exit;;
*) echo " OPCIÓN NO VÁLIDA "
exit 1;;
esac
