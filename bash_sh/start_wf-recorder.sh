#!/bin/bash
if pgrep -x "wf-recorder" >/dev/null; then
  killall wf-recorder
  notify-send "stop recorder"
else
  wf-recorder -f ~/video/seceen/$(date +%Y-%m-%d_%H-%M-S).mp4 --audio
  notify-send "start recorder"
fi
