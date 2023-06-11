# ~/.config/xprofile.d/99-ddgr.sh
# duckduckgo rofi
if [ $(command -v ddgr) ] && [ $(command -v rofi-search) ]; then
    export ROFI_SEARCH=ddgr
fi
