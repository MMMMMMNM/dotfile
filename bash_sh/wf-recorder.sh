if pgrep -x "wf-recorder" >/dev/null; then
  echo '{"text": "","tooltip":"active", "class": "recorder"}'
else
  echo '{"text": "","tooltip":"disactive", "class": "not-recorder"}'
fi
