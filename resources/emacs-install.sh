#!/bin/bash

sudo pacman -S emacs --noconfirm

if [ $? -eq 0 ]; then
    mkdir ~/.emacs.d
    cp -r Emacs/emacs-linux ~/.emacs
    cp -r Emacs/emacs.d/lisp ~/.emacs.d
    cp -r Emacs/emacs.d/execute.sh ~/.emacs.d
    cp -r Emacs/emacs-tutorial.org ~/.emacs.d
    cp -r Emacs/dired-ref.pdf ~/.emacs.d
    cp -r Emacs/refcard.pdf ~/.emacs.d
    cp -r Emacs/pylintrc ~/.pytlintrc
    echo -n ""
    echo "OK"
else
    echo -n ""
    echo "Installación fallida :("
fi
