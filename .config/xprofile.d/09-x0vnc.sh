# ~/.config/xprofile.d/09-x0vnc.sh
# x0vnc

case "${HOSTNAME}" in
    "tanzania")
        x0vncserver -rfbauth ~/.vnc/passwd -UseIPv6 -rfbport 5912 &
        ;;
esac
