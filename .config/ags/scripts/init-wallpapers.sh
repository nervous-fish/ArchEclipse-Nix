#!/bin/bash

hyprpaper_conf=$ARCHECLDATA/hyprpaper/config       # hyprpaper config
defaults=$HOME/.config/hypr/hyprpaper/config/defaults.conf # backup config

default_wallpapers=$HOME/.config/wallpapers/defaults # default wallpapers directory
custom_wallpapers=$HOME/.config/wallpapers/custom    # custom wallpapers directory
all_wallpapers=$HOME/.config/wallpapers/all          # all wallpapers directory

#################################################

# overwrite /usr/share/backgrounds with all wallpapers
# rm -rf /usr/share/backgrounds/* && cp -r $all_wallpapers/* /usr/share/backgrounds

# echo "Wallpapers for sddm updated!"

#################################################

monitors=$(hyprctl monitors | awk '/Monitor/ {print $2}')

for monitor in $monitors; do
    monitor_conf=$hyprpaper_conf/$monitor/defaults.conf

    if [ ! -s "$monitor_conf" ]; then
        mkdir -p $hyprpaper_conf/$monitor
        touch $monitor_conf
        cp $defaults $monitor_conf

        echo "Config file created! for $monitor"
    fi
done

echo "Config files created!"

#################################################

for conf in $hyprpaper_conf/*/defaults.conf; do
    monitor=$(basename $conf/defaults.conf)

    wallpapers=$(awk -F'=' '{print $2}' $conf)

    for wallpaper in $wallpapers; do
        hyprctl hyprpaper preload "$wallpaper"
    done
done

echo "Wallpapers preloaded!"

#################################################

./scripts/auto-wallpapers.sh & # start auto wallpaper script

echo "Auto wallpaper script started!"
