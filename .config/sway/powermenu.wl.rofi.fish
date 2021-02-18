#!/bin/fish

### Variables
set theme card_circle.rasi
set dir ~/.config/rofi/powermenu
set uptime (uptime -p | sed -e 's/up //g') 
set focused (swaymsg -t get_outputs | jq 'map(.focused) | reverse  | index(true)')

### Power Options
set shutdown 
set reboot 
set lock 
set suspend 
set logout 

### Confirmation
function confirm_exit
	rofi -dmenu -i -no-fixed-num-lines -p "Are You Sure? [y/n] ● " -config $dir/confirm.rasi -monitor $focused
end

### Message
function msg
	rofi -config $dir'/message.rasi' -e 'Available Options  -  y / n' -monitor $focused
end

### Icon Menu
set options $shutdown\n$reboot\n$lock\n$suspend\n$logout
### Answer
set chosen (echo -e $options | rofi -config $dir/$theme -p 'Goodbye, '$USER -dmenu -selected-row 2 -monitor $focused)

switch $chosen
	case $shutdown
		set ans (confirm_exit)
		if test $ans = 'y'
			systemctl poweroff
		else if test $ans = 'n'
			exit 0
		else
			msg
		end
	case $reboot
		set ans (confirm_exit)
		if test $ans = 'y'
			systemctl reboot
		else if test $ans = 'n'
			exit 0
		else
			msg
		end
	case $lock
		betterlockscreen -l
	case $suspend
		set ans (confirm_exit)
		if test $ans = 'y'
			playerctl pause
			systemctl suspend
		else if test $ans = 'n'
			exit 0
		else
			msg
		end
	case $logout	
		set ans (confirm_exit)
		if test $ans = 'y'
			swaymsg exit
		else if test $ans = 'n'
			exit 0
		else
			msg
		end
end
