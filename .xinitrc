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
# shellcheck disable=1090
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "${f}" ] && . "${f}"
    done
    unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced.
# shellcheck disable=1091
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f "${HOME}"/.xprofile ] && . "${HOME}"/.xprofile

if [ "${DISTRO}" = "freebsd" ];then
    # need to source ~/.profile again to make sure all
    # XDG_* are defined
    # shellcheck disable=1091
    . "${HOME}"/.profile
fi

case ${1} in
    qtile)
        if [ "$(command -v dbus-launch)" ]; then
            dbus-launch --exit-with-session ${1} start
        else
            exec ${1} start
        fi
        ;;
    *)
        if [ "$(command -v dbus-launch)" ]; then
            dbus-launch --exit-with-session ${1}
        else
            exec ${1}
        fi
        ;;
esac
