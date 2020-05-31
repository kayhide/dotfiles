set-monitor() {
    local monitor="$1"
    local mode="$2"
    local pos="${3:-0x0}"
    xrandr --output $monitor --mode $mode --pos $pos
}

set-monitor eDP-1 2560x1440
set-monitor DP-3 1920x1080 2560x0
set-monitor eDP1 2560x1440
set-monitor DP3 1920x1080 2560x0

ergo &
keynav &
unclutter &
nm-applet &
parcellite &
pasystray &
xautolock -locker "i3lock --color '#332233'"  -time 5 -detectsleep &
picom --experimental-backends &

~/bin/wallpaper ~/.wallpaper &

if [[ -n ${SAVE_LAST_PWD+x} && -f $SAVE_LAST_PWD ]]; then
    rm $SAVE_LAST_PWD
fi
