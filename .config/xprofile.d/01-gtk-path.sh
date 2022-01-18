# ~/.config/xprofile.d/01-gtk-path.sh
# set new location for GTK and GTK2
# https://wiki.archlinux.org/title/XDG_Base_Directory
# <alexforsale@yahoo.com>

export GTK_RC_FILES="${XDG_CONFIG_HOME}"/gtk-1.0/gtkrc
[ -d "${GTK_RC_FILES%%/gtkrc}" ] && mkdir -p "${GTK_RC_FILES%%/gtkrc}"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
[ -d "${GTK2_RC_FILES%%/gtkrc}" ] && mkdir -p "${GTK2_RC_FILES%%/gtkrc}"
