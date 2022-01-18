# ~/.config/xprofile.d/07-filemanager.sh
# file manager configuration

[ "$(command -v udiskie)" ] &&
    udiskie &

[ "${_WM}" = "i3" ] &&
    export _NO_PCMANFM=1

# pcmanfm
if [ $(command -v pcmanfm) ] &&
       [ -z ${_NO_PCMANFM} ]; then
    pcmanfm --desktop -d &
fi
