#!/bin/bash

dataDir=$ARCHECLDATA/hyprpaper
current_wallpaper=$(cat $dataDir/config/current.conf)
current_theme=$(bash ./scripts/system-theme.sh get)

killall wal

# check if $1 is provided
if [ $1 ]; then
    current_wallpaper=$1
else
    current_wallpaper=$(cat $dataDir/config/current.conf)
fi

current_wallpaper=${current_wallpaper/\$HOME/$HOME}

if [ "$current_theme" = "dark" ]; then

    wal --backend colorthief -e -n -i "$current_wallpaper" >/dev/null 2>&1

elif [ "$current_theme" = "light" ]; then

    wal --backend colorthief -e -n -i "$current_wallpaper" -l >/dev/null 2>&1
fi

# pywalfox update
