#!/bin/bash
WALLPAPER_DIR="$HOME/dotfile/hypr/.config/hypr/pic/circular"
WALLPAPER_CHANGE_EFFECT="-t outer --transition-pos 0.854,0.977 --transition-step 90"
while true; do
  WALLPAPER=$(ls $WALLPAPER_DIR | shuf -n 1)
  swww img $WALLPAPER_CHANGE_EFFECT "$WALLPAPER_DIR/$WALLPAPER"
sleep 300
done
