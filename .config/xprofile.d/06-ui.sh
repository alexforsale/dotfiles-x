#!/bin/sh
# ~/.config/xprofile.d/06-ui.sh
# various ui settings

# wallpaper
if [ -e ~/.local/bin/wallpaper ]; then
    ~/.local/bin/setwallpaper &
fi

# qutebrowser settings
if [ "${DISTRO}" != "freebsd" ] &&
       [ $(command -v qutebrowser) ]; then
    export QUTEWAL_DYNAMIC_LOADING=1
fi

# unclutter
[ "$(command -v unclutter)" ] &&
    unclutter &

# picom
if [ "$(command -v picom)" ] &&
    [ -e "${XDG_CONFIG_HOME}/picom/picom.conf" ]; then
    picom -b --config "${XDG_CONFIG_HOME}"/picom/picom.conf &
fi

# polybar
if [ $(command -v polybar-launch) ] &&
       [ -z ${_NO_POLYBAR} ]; then
    polybar-launch &
fi

# also merge Xresources here in case using
# lightdm and such.
[ -e ~/.Xresourses ] &&
    xrdb -merge "${HOME}"/.Xresources &
