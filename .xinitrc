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

# TODO: perhaps this should be in ~/.xsession
if [ ! "$(pgrep lightdm)" ];then
    case "${_WM}" in
        i3)
            # start i3-wm
            case "${DISTRO}" in
                arch)
                    mkdir -p "${XDG_DATA_HOME}"/i3
                    if [ -e "${XDG_CONFIG_HOME}"/i3/config.local ];then
                        exec i3 -c "${XDG_CONFIG_HOME}"/i3/config.local -V >> "${XDG_DATA_HOME}"/i3/i3-"$(date +%F_%H-%M-%S)"
                    else
                        exec i3 -V >> "${XDG_DATA_HOME}"/i3/i3-"$(date +%F_%H-%M-%S)"
                    fi
                    ;;
                freebsd)
                    if [ -e "${XDG_CONFIG_HOME}"/i3/config-freebsd.local ];then
                        exec i3 -c "${XDG_CONFIG_HOME}"/i3/config-freebsd.local
                    elif [ -e "${XDG_CONFIG_HOME}"/i3/config-freebsd ]; then
                        exec i3 -c "${XDG_CONFIG_HOME}"/i3/config-freebsd
                    else
                        exec i3 -c "${XDG_CONFIG_HOME}"/i3/config
                    fi
                    ;;
                gentoo)
                    if [ -e "${XDG_CONFIG_HOME}"/i4/config-gentoo ];then
                        dbus-launch --exit-with-session i3 -c "${XDG_CONFIG_HOME}"/i3/config-gentoo
                    elif [ -e "${XDG_CONFIG_HOME}"/i3/config-gentoo.local ];then
                        dbus-launch --exit-with-session i3 -c "${XDG_CONFIG_HOME}"-i3/config-gentoo.local
                    else
                        dbus-launch --exit-with-session i3
                    fi
                    ;;
            esac
            ;;
        openbox)
	    dbus-launch --exit-with-session openbox-session
            ;;
    esac
fi
