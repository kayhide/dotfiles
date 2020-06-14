set-monitor() {
    local monitor="$1"
    local mode="$2"
    local pos="${3:-0x0}"
    xrandr --output $monitor --mode $mode --pos $pos
}

# set-monitor eDP-1 2560x1440
# set-monitor DP-3 1920x1080 2560x0
xrandr --listmonitors |tail -n +2 |while read -r line; do
    name="${line##* }"
    if [[ $line =~ "*" ]]; then
        set-monitor "$name" 2560x1440
    elif [[ $name =~ 3 ]]; then
        set-monitor "$name" 1920x1080 2560x0
    fi
done

ergo &
keynav &
unclutter &
parcellite &
pasystray &
picom --experimental-backends &
dropbox &

xrandr --listmonitors |tail -n +2 |while read -r line; do
    head="${line%:*}"
    conky --xinerama-head="$head" --config ~/.config/conky/clock.conf &
done

~/bin/wallpaper ~/.wallpaper &

if [[ -n ${SAVE_LAST_PWD+x} && -f $SAVE_LAST_PWD ]]; then
    rm $SAVE_LAST_PWD
fi

(sleep 5; systemctl --user restart polybar) &
