#!/bin/sh
# ~/.config/xprofile.d/06-ui.sh
# various ui settings

# monitor
_count=0
for i in $(xrandr | grep " connected"| awk '{print $1}');do
    _count=$((_count+1))
    export MONITOR${_count}=${i}
done
unset _count

# qutebrowser settings
if [ "${DISTRO}" != "freebsd" ] &&
       [ $(command -v qutebrowser) ]; then
    export QUTEWAL_DYNAMIC_LOADING=1
fi

# For when using display managers
if [ -z "$_WM" ]; then
    [ -n "${DESKTOP_SESSION}" ] && export _WM="${DESKTOP_SESSION}"
    [ -n "${XDG_SESSION_DESKTOP}" ] && export _WM="${_WM:-$XDG_SESSION_DESKTOP}"
    [ -n "${XDG_CURRENT_DESKTOP}" ] && export _WM="${_WM:-$XDG_CURRENT_DESKTOP}"
fi
