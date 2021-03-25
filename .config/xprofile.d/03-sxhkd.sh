#!/bin/sh
# ~/.config/xprofile.d/03-sxhkd.sh
# sxhkd settings
# <alexforsale@yahoo.com>

if [ -z "${_NO_SXHKD}" ] && [ ! $(pgrep -u ${USER} -x sxhkd) ] &&
   [ $(command -v sxhkd) ]; then
    if [ -e "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc.local ];then # per-user configuration
        sxhkd -c "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc.local &
    elif [ -e "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc-"${DISTRO}" ];then # per-distro configuration, i.e. sxhkdrc-arch
        sxhkd -c "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc-"${DISTRO}" &
    elif [ -e "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc-"${_WM}" ];then # per WM configuration, i.e. sxhkdrc-i3
        sxhkd -c "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc-"${_WM}" &
    else
        sxhkd -c "${XDG_CONFIG_HOME}"/sxhkd/sxhkdrc &
    fi
fi
