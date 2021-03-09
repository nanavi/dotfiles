#!/usr/bin/sh

while xsetroot -name "`date` `uptime`"
do
    sleep 1
done &

#setxkbmap -layout us,es grp:lctrl_lwin_toggle
setxkbmap -option caps:escape
xset r rate 300 50
xinput --set-prop 9 'libinput Accel Profile Enabled' 0, 1
xset m 0 0
feh --bg-fill ~/.wallpapers/background
# ~/scripts/bar.sh &
dunst &
picom &
