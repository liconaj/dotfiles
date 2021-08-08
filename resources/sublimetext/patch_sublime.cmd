:: for Win64
cd /d "C:\Program Files\Sublime Text" || exit
printf '\x48\x31\xC0\xC3'                 | dd of=sublime_text.exe bs=1 seek=673762 conv=notrunc
printf '\x90\x90\x90\x90\x90'             | dd of=sublime_text.exe bs=1 seek=28970  conv=notrunc
printf '\x90\x90\x90\x90\x90'             | dd of=sublime_text.exe bs=1 seek=28995  conv=notrunc
printf '\x48\x31\xC0\x48\xFF\xC0\xC3'     | dd of=sublime_text.exe bs=1 seek=680665 conv=notrunc
printf '\xC3'                             | dd of=sublime_text.exe bs=1 seek=672853 conv=notrunc
printf '\xC3'                             | dd of=sublime_text.exe bs=1 seek=1024   conv=notrunc
