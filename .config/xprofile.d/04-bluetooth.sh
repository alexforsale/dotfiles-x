#!/bin/sh
# ~/.config/xprofile.d/04-bluetooth.sh
# bluetooth configuration

# blueman-tray
if [ "$(command -v blueman-tray)" ] &&
       [ -z "${_NO_BLUEMAN_TRAY}" ]; then
    blueman-tray &
fi
