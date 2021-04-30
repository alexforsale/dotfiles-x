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

# unclutter
[ "$(command -v unclutter)" ] &&
    unclutter &

# wal
if [ $(command -v wal) ] && [ -z "${SSH_CLIENT}" ]; then
    wal -R >/dev/null 2>&1
fi

# also merge Xresources here in case using
# lightdm and such.
[ -e ~/.Xresourses ] &&
    xrdb -merge "${HOME}"/.Xresources &
