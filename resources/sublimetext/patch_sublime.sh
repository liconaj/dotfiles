#!/bin/sh

# https://gist.github.com/maboloshi/feaa63c35f4c2baab24c9aaf9b3f4e47

# ST 4121

# for Linux
cd /opt/sublime_text || exit
#md5sum -c <<<"D3343AD6D13F816F1F9414223B8BE091  sublime_text" || exit
printf '\x48\x31\xC0\xC3'                 | dd of=sublime_text bs=1 seek=$((0x00375A48)) conv=notrunc
printf '\x90\x90\x90\x90\x90'             | dd of=sublime_text bs=1 seek=$((0x0036BC85)) conv=notrunc
printf '\x90\x90\x90\x90\x90'             | dd of=sublime_text bs=1 seek=$((0x0036BC9B)) conv=notrunc
printf '\x48\x31\xC0\x48\xFF\xC0\xC3'     | dd of=sublime_text bs=1 seek=$((0x003774CB)) conv=notrunc
printf '\xC3'                             | dd of=sublime_text bs=1 seek=$((0x0037570C)) conv=notrunc
printf '\xC3'                             | dd of=sublime_text bs=1 seek=$((0x0035F930)) conv=notrunc
