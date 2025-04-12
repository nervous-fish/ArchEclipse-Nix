#!/bin/bash

dataDir=$ARCHECLDATA/hypr
current_theme=$(bash ./scripts/system-theme.sh get)

hyprctl setcursor theme_phinger-cursors-$current_theme 24
gsettings set org.gnome.desktop.interface cursor-theme theme_phinger-cursors-$current_theme

echo -e "env = HYPRCURSOR_THEME,theme_phinger-cursors-$current_theme \nenv = XCURSOR_THEME,phinger-cursors-$current_theme" >$dataDir/configs/cursor.conf
