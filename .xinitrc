case $WM in
qtile)
	export XDG_SESSION_TYPE=x11
	export GDK_BACKEND=x11
	exec qtile
	;;
dwm)
	while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
	do
	    sleep 1
	done &
	echo selected DWM
	exec feh --bg-center ~/Downloads/83415811_p0.png &
	exec dwm
	;;
gnome)
	export XDG_SESSION_TYPE=x11
	export GDK_BACKEND=x11
	echo selected default GNOME
	exec feh --bg-center ~/Downloads/83415811_p0.png &
	exec gnome-session
	;;
*)
	echo selected default DWM
	# exec feh --bg-center ~/Downloads/83415811_p0.png &
	exec dwm
	;;
esac
