#!/bin/sh
# ~/.xinitrc
# Configuration script for manual X session.
# <alexforsale@yahoo.com>
userresources=${HOME}/.Xresources
usermodmap=${HOME}/.Xmodmap
OS=$(uname -s)

case "${OS}" in
    "Linux")
        if [ "${DISTRO}" = "ubuntu" ]; then
            sysresources=/etc/X11/xinit/Xresources
            sysmodmap=/etc/X11/xinit/Xmodmap
        else
            sysresources=/etc/X11/xinit/.Xresources
            sysmodmap=/etc/X11/xinit/.Xmodmap
        fi
        ;;
    "FreeBSD")
        sysresources=/usr/local/etc/X11/xinit/.Xresources
        sysmodmap=/usr/local/etc/X11/xinit/.Xmodmap
        ;;
esac
[ -f "${sysresources}" ] &&
    xrdb -merge "${sysresources}"

[ -f "${sysmodmap}" ] &&
    xmodmap "${sysmodmap}"

[ -f "${userresources}" ] &&
    xrdb -merge "${userresources}"

[ -f "${usermodmap}" ] &&
    xmodmap "${usermodmap}"
# shellcheck disable=1090
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "${f}" ] && . "${f}"
    done
    unset f
fi
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f "${HOME}"/.xprofile ] && . "${HOME}"/.xprofile
[ -z ${DESKTOP_SESSION} ] && export DESKTOP_SESSION=${1:-exwm}
# for archlinux
[ -d /usr/share/backgrounds/archlinux/ ] &&
    feh -zr --bg-fill /usr/share/backgrounds/archlinux/
# FreeBSD
[ -d /usr/local/share/wallpapers/freebsd-8k-wallpapers/ ] &&
    feh -zr --bg-fill /usr/local/share/wallpapers/freebsd-8k-wallpapers/
for chemacs_profile in ~/.emacs-profile ~/.config/chemacs/profile; do
    if [ -e ${chemacs_profile} ]; then
        export CHEMACS_PROFILE=`cat ${chemacs_profile}`
    fi
done

if [ -n "${CHEMACS_PROFILE}" ]; then
    _emacs_args="-s ${CHEMACS_PROFILE}"
fi
case $DESKTOP_SESSION in
    "exwm")
        exec emacs --debug-init -l ~/.exwm
        ;;
    "qtile")
        exec qtile start
        ;;
    "stumpwm")
        if [ $(command -v ros) ]; then
            exec ros run -- --load /usr/local/bin/startstumpwm
        elif [ $(command -v sbcl) ]; then
            exec sbcl --load /usr/local/bin/startstumpwm
        fi
        ;;
esac
