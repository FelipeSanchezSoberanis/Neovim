#!/usr/bin/env bash

file=$(fdfind --base-directory /home/felipe/ -e pdf -I | rofi -dmenu -theme ~/.config/rofi/launchers/type-4/style-2.rasi)

# Exit if $file is empty
if test -z "$file"
then
    exit
fi

nohup zathura /home/felipe/$file > /dev/null

