#!/bin/bash

tofu $1
retorno=$?

if [ $retorno -eq 0 ]; then
    echo "[Process finished with exit code 0]"
else
    echo "[Procees finished with error(s)]"
fi

# Hide cursor
tput civis

# Wait for input
read
