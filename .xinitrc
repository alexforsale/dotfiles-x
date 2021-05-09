#!/bin/sh
userresources=${HOME}/.Xresources
usermodmap=${HOME}/.Xmodmap

# $DISTRO is set by "~/.profile"
if [ "${DISTRO}" = "ubuntu" ]; then
    sysresources=/etc/X11/xinit/Xresources
    sysmodmap=/etc/X11/xinit/Xmodmap
else
    sysresources=/etc/X11/xinit/.Xresources
    sysmodmap=/etc/X11/xinit/.Xmodmap
fi
# merge in defaults and keymaps

[ -f "${sysresources}" ] &&
    xrdb -merge "${sysresources}"

[ -f "${sysmodmap}" ] &&
    xmodmap "${sysmodmap}"

[ -f "${userresources}" ] &&
    xrdb -merge "${userresources}"

[ -f "${usermodmap}" ] &&
    xmodmap "${usermodmap}"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "${f}" ] && . "${f}"
    done
    unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f "${HOME}"/.xprofile ] && . "${HOME}"/.xprofile

if [ "${DISTRO}" = "freebsd" ];then
    # need to source ~/.profile again to make sure all
    # XDG_* are defined
    . "${HOME}"/.profile
fi

case "${_WM}" in
    i3)
        if [ "$(command -v dbus-launch)" ]; then
            if [ -f "${XDG_CONFIG_HOME}"/i3/config-"${DISTRO}" ]; then
                dbus-launch --exit-with-session i3 -c "${XDG_CONFIG_HOME}"/i3/config-"${DISTRO}"
            elif [ -f "${XDG_CONFIG_HOME}"/i3/config-"${DISTRO}".local ]; then
                dbus-launch --exit-with-session i3 -c "${XDG_CONFIG_HOME}"/i3/config-"${DISTRO}".local
            else
                continue
            fi
        fi
        ;;
    openbox)
        if [ "$(command -v dbus-launch)" ]; then
            dbus-launch --exit-with-session openbox-session
        fi
        ;;
    *)
        # default settings
        if [ "$(command -v dbus-launch)" ]; then
            if [ "$(command -v i3)" ];then
                dbus-launch --exit-with-session i3
            elif [ "$(command -v openbox-session)" ]; then
                dbus-launch --exit-with-session openbox-session
            fi
        fi
        ;;
esac
