# ~/.config/xprofile.d/08-multimedia.sh
# various multimedia app

# mpd
if $(command -v mpd);then
    [ ! -e "${XDG_CONFIG_HOME}"/mpd/pid ] && mpd "${mpd_conf_file}" &
fi
