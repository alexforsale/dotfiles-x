#!/bin/sh
# ~/.config/xprofile.d/01-emacs.sh
# emacs configuration
# <alexforsale@yahoo.com>

# start emacs as daemon
# only when _NO_EMACS_DAEMON is unset
if [ -z "${_NO_EMACS_DAEMON}" ] && [ ! "$(pgrep -u ${USER} -x emacs)" ];then
    emacs --daemon &
fi
