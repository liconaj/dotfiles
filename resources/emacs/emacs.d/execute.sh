#!/bin/bash

file=$1

filename="${file%.*}"
basename=$(basename -- "$file")
extension="${file##*.}"

temp="$(dirname -- "$file")/.$basename"

case $extension in

    py)
        python -u $file
        retorno=$?
        ;;
    lua)
        lua $file
        retorno=$?
        ;;
    bas)
        if [ ! -f "$filename" ]; then
            fbc $file -x $temp &>/dev/null
            $temp
        else
            $filename
        fi
        retorno=$?
	read
        ;;
    cpp)
        if [ ! -f "$filename" ]; then
            g++ -o $temp $file &>/dev/null
            $temp
        else
            $filename
        fi
        retorno=$?
        ;;
    c)
        if [ ! -f "$filename" ]; then
            gcc -o $temp $file &>/dev/null
            $temp
        else
            $filename
        fi
        retorno=$?
        ;;
    *)
        $file
        retorno=$?
        ;;
esac


echo -e "\n"
echo "-----------------------------------"

if [ $retorno -eq 0 ]; then
    echo "[Process finished with exit code 0]"
else
    echo "[Procees finished with error(s)]"
fi

# Hide cursor
tput civis

# Wait for input
read

if [[ -f "$temp" ]]; then
    rm $temp
fi
