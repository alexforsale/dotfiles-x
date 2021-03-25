#!/bin/sh
# ~/.config/xprofile.d/07-filemanager.sh
# file manager configuration

[ "$(command -v udiskie)" ] &&
    udiskie &

# pcmanfm
if [ $(command -v pcmanfm) ] &&
       [ -z ${_NO_PCMANFM} ]; then
    pcmanfm --desktop -d &
fi
