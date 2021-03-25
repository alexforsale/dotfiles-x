#!/bin/sh
# ~/.config/xprofile.d/00-security.sh
# various ui-related security settings
# <alexforsale@yahoo.com>

if [ "$(command -v gnome-keyring-daemon)" ] &&
   [ ! $(pgrep -u ${USER} -x gnome-keyring-d) ];then
    eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
    export SSH_AUTH_SOCK GNOME_KEYRING_CONTROL
fi

case "${DISTRO}" in
    gentoo)
        [ -f /usr/bin/x11-ssh-askpass ] &&
            export SSH_ASKPASS=/usr/bin/x11-ssh-askpass &&
            export SUDO_ASKPASS=/usr/bin/x11-ssh-askpass

        # polkit
        if [ ! "$(pgrep -u ${USER} -x polkit-gnome-au)" ];then
            sleep 1 && /usr/libexec/polkit-gnome-authentication-agent-1 &
        fi
        ;;
    arch)
        if [ -f /usr/lib/ssh/x11-ssh-askpass ];then
            ln -s /usr/lib/ssh/x11-ssh-askpass ~/.local/bin/ssh-askpass &
            export SSH_ASKPASS=ssh-askpass
            export SUDO_ASKPASS="${HOME}"/.local/bin/ssh-askpass
        fi
        # polkit
        if [ ! "$(pgrep -u ${USER} -x polkit-gnome-authentication-agent-1)" ];then
            sleep 1 && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
        fi

        # keyring
        [ "$(command -v dbus-update-activation-environment)" ] &&
            dbus-update-activation-environment --systemd DISPLAY
        ;;
    freebsd)
        [ -f /usr/local/bin/x11-ssh-askpass  ] &&
            export SSH_ASKPASS=/usr/local/bin/x11-ssh-askpass &&
            export SUDO_ASKPASS=/usr/local/bin/x11-ssh-askpass

        # polkit
        if [ ! "$(pgrep -u ${USER} -x polkit-gnome-authentication-agent-1)" ];then
            sleep 1 && /usr/local/libexec/polkit-gnome-authentication-agent-1 &
        fi
        ;;
esac
