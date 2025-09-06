#!/bin/bash
if pgrep -x "waylrc" >/dev/null; then
  killall waylrc
  killall waybar
  waybar
else
  waylrc
fi
