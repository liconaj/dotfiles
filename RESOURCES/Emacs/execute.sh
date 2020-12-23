#!/bin/bash


file=$1
prompt=$2

filename="${file%.*}"
basename=$(basename -- "$file")
extension="${file##*.}"

temp="$(dirname -- "$file")/.$basename"

case $extension in

    py)
        python -u $file
        retorno=$?
        ;;
    bas)
        if [ ! -f "$filename" ]; then
            fbc $file -x $temp &>/dev/null
            $temp
        else
            $file
        fi
        retorno=$?
        ;;
    cpp)
        if [ ! -f "$filename" ]; then
            g++ -o $temp $file &>/dev/null
            $temp
        else
            $file
        fi
        retorno=$?
        ;;
    c)
        if [ ! -f "$filename" ]; then
            gcc -o $temp $file &>/dev/null
            $temp
        else
            $file
        fi
        retorno=$?
        ;;
    *)
        $file
        retorno=$?
        ;;
esac


if (( $prompt == "-p")); then

    echo -e "\n"

    if [ $retorno -eq 0 ]; then
        echo "[Process finished with exit code 0]"
    else
        echo "[Procees finished with error(s)]"
    fi

    # Hide cursor
    tput civis

    # Wait for input
    read
fi

if [[ -f "$temp" ]]; then
    rm $temp
fi
