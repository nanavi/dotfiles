#!/bin/fish

set focused (swaymsg -t get_outputs | jq 'map(.focused) | reverse  | index(true)')

rofi -show drun -modi drun,run,window -monitor $focused
