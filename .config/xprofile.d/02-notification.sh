# ~/.config/xprofile.d/02-notification.sh
# notification settings
# <alexforsale@yahoo.com>

# dunst
if [ "$(command -v dunst)" ];then
    case "${DISTRO}" in
        arch)
            if [ ! $(pgrep -u ${USER} -x dunst) ] &&
                   [ -e ${XDG_CONFIG_HOME}/dunst/dunstrc ]; then
                dbus-launch --sh-syntax --exit-with-session dunst -conf ${XDG_CONFIG_HOME}/dunst/dunstrc &
            fi
            ;;
    esac
fi
