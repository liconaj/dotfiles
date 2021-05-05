#!/bin/sh


[ ! -d build ] && mkdir build
cd build

if [ "$2" == "static" ]; then
	echo "Compiling raylib file statically..."
	gcc ../$1.c -g -std=c99 -c -I /usr/local/include -o $1.o
	gcc ../$1.c -s -Wall -std=c99 -I/usr/local/include -L/usr/local/lib -lraylib -lm -lpthread -ldl -o $1
elif [ "$2" == "run "]; then
	echo "Compiling raylib file..."
	gcc ../$1.c -g -std=c99 -c -o $1.o
	gcc ../$1.c -s -Wall -std=c99 -lraylib -lm -lpthread -ldl -o $1 && ./$1
else
	echo "Compiling raylib file..."
	gcc ../$1.c -g -std=c99 -c -o $1.o
	gcc ../$1.c -s -Wall -std=c99 -lraylib -lm -lpthread -ldl -o $1
fi

[ -f $1.o ] && rm $1.o

cd ..
