#!/bin/bash
info=$(hyprctl -j activewindow)
hyprctl activewindow > ~/dotfile/hypr/.config/hypr/script/window.txt
class=$(echo $info | jq -r '.class')
title=$(echo $info | jq -r '.title')
notify-send "Class: $class, Title: $title"
