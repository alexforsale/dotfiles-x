#!/bin/sh
# ~/.config/xprofile.d/05-network.sh
# various networking app

# nm-applet
if [ "$(command -v nm-applet)" ] &&
       [ -z "${_NO_NM_APPLET}" ];then
    nm-applet &
fi
