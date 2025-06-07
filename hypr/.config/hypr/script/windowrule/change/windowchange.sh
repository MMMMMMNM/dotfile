#!/bin/bash
hyprctl keyword windowrulev2 "opacity 0.8 0.5, class:^(zen)$"
hyprctl reload
notify-send "change"
