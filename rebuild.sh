#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
    exit 1
fi

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
user=$(eval echo "~$SUDO_USER")
nixos="/etc/nixos"
temp="$dir/temp"

rmd () { [ -d "$1" ] && rm -rf "$1"; }
rmdUsr () { rmd "$user$1"; }
cpdUsr () { rmdUsr "$2"; cp -r "$dir$1" "$user$2"; } 

cpfUsr () { cp "$dir$1" "$user$2"; } 

# Clone hyprland config
cpdUsr "/config/hypr" "/.config/hypr"

# Clone waybar config
cpdUsr "/config/waybar" "/.config/waybar"

# Clone bash config
cpfUsr "/config/.bashrc" "/.bashrc"
source $user/.bashrc

# Rebuild nix
read -p "Rebuild NixOS? (y/n) [N]: " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    
    echo "NixOS Rebuilding..."
    
    nixos-rebuild switch --upgrade &>"$temp/nixos-switch.log"

    cat "$temp/nixos-switch.log" | clolcat
    cat "$temp/nixos-switch.log" | grep --color error && false
fi

# Reboot
read -p "Reboot? (y/n) [N]: " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    reboot
fi