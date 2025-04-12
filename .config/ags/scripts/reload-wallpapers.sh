#!/bin/bash

hyprctl hyprpaper unload all # unload wallpaper
killall auto-wallpapers.sh              # kill auto.sh

nohup ./scripts/init-wallpapers.sh & # load wallpaper
