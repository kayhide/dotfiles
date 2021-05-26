set-monitor eDP-1 2560x1440

ergo &
keynav &
unclutter &
parcellite &
pasystray &
dropbox &

# Monitor relatetd settings
# Waiting 5 seconds is good enough for monitors to get ready.
sleep 5

systemctl --user restart conky-clock &
systemctl --user restart wallpaper &
systemctl --user restart polybar &
