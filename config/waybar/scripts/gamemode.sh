if [[ $(hyprctl submap) == gaming ]]; then
  echo '{"text": "󰊴", "tooltip": "SUPER + CTRL + G to disable", "class": "active"}'
else
  echo '{"text": ""}'
fi
