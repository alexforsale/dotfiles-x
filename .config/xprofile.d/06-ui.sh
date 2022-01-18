# ~/.config/xprofile.d/06-ui.sh
# various ui settings
# monitor
_count=0
for i in $(xrandr | grep " connected"| awk '{print $1}');do
    _count=$((_count+1))
    export MONITOR${_count}=${i}
done
unset _count
