#!/bin/sh


LINTER=no
THEMES=yes
CONSOLE=yes
EOFNEWLINE=yes

LITECONFIG=$HOME/.config/lite-xl

plugins=( "autoinsert" "autosave" "bracketmatch" "indentguide" "lfautoinsert" "restoretabs" "scale" "language_go" "gofmt" )
linters=( "gocompiler" "luacheck" "golint"  )


[ ! -d lite-plugins ] && git clone https://github.com/franko/lite-plugins

for p in ${plugins[@]}; do
	cp -r lite-plugins/plugins/${p}.lua $LITECONFIG/plugins
done
rm -r lite-plugins

if [ $EOFNEWLINE == yes ]; then
	link=https://raw.githubusercontent.com/bokunodev/lite_modules/master/plugins/eofnewline-xl.lua
	curl $link -fso $LITECONFIG/plugins/eofnewline-xl.lua
fi

if [ $LINTER == yes ]; then
	[ -d linters ] && sudo rm -r linters
	git clone https://github.com/drmargarido/linters
	sed -i 's/golint/revive/g' linters/linter_golint.lua
	for f in "linters/*.lua"; do
		sed -i '1s/^/-- mod-version:1 -- lite-xl 1.16\n/' $f
	done
	cp linters/linter.lua $LITECONFIG/plugins
	for l in ${linters[@]}; do
		cp -r linters/linter_${l}.lua $LITECONFIG/plugins
	done
	rm -r linters
fi

if [ $THEMES == yes ]; then
	[ ! -d lite-colors ] && git clone https://github.com/rxi/lite-colors
	cp -r lite-colors/colors/*.lua $LITECONFIG/colors
	rm -r lite-colors
fi

if [ $CONSOLE == yes ]; then
	[ ! -d console ] && git clone https://github.com/franko/console
	cp -r console/init.lua $LITECONFIG/plugins/console.lua
	rm -r console
fi

sudo cp lite-xl.svg /usr/share/icons/hicolor/scalable/apps/
