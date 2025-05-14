#!/usr/bin/env bash

while getopts "hbrg" opt; do
    case ${opt} in
        h)
            echo "-b : rebuild NixOS" 
            echo "-r : do not hide messages" 
            echo "-g : disk optimizations" 
            exit 1 ;;
        b) build=true ;;
        r) raw=true ;;
        g) diskopt=true ;;
        \?) exit 1 ;;
        :) exit 1 ;;
    esac
done

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
usr=$(eval echo "~$SUDO_USER")
nixos="/etc/nixos"
temp="$dir/temp"

rmd () { [ -d "$1" ] && sudo rm -rf "$1"; }
rmdUsr () { rmd "$usr$1"; }
cpdUsr () { rmdUsr "$2"; sudo cp -r "$dir$1" "$usr$2"; } 
cpfUsr () { sudo cp "$dir$1" "$usr$2"; } 

# Clone hyprland config
cpdUsr "/config/hypr" "/.config/hypr"
hyprctl reload > /dev/null 2>&1 &

# Clone waybar config
cpdUsr "/config/waybar" "/.config/waybar"
sudo mv "$usr/.config/waybar/config.jsonc" "$usr/.config/waybar/config"
killall .waybar-wrapped; nohup waybar 2>/dev/null &

# Clone bash config
cpfUsr "/config/.bashrc" "/.bashrc"
source $usr/.bashrc

# Clone alacritty config
sudo mkdir -p "$usr/.config/alacritty"
cpfUsr "/config/alacritty.toml" "/.config/alacritty/alacritty.toml"

# Clone flake
cpdUsr "/flake" "/.flake"

if [[ -n "$build" ]]; then
    
    echo "NixOS Rebuilding..."

    if [[ -z "$raw" ]]; then 
    
        sudo bash -c "nix-collect-garbage &>'$temp/nixos-clean.log'"; 
        sudo bash -c "sudo nixos-rebuild switch --upgrade --flake "$usr/.flake" --impure &>'$temp/nixos-switch.log'"; 

        if grep -q 'error:' "$temp/nixos-switch.log"; then
            awk '
            /error: / {
                if (!(seen[$0]++)) {
                    if (block) print ""
                    print $0
                    getline
                    print $0
                    block = 1
                }
            }' \
            "$temp/nixos-switch.log" \
            | sed 's/^[ \t]*//;s/[ \t]*$//' \
            | sed -E \
                -e 's/error:/\x1b[31m&\x1b[0m/g' \
                -e 's/at /\x1b[34m&\x1b[0m/g' \
            | cat \
            | boxes -d tux
        else
            echo "DONE!" | figlet | boxes -d parchment | clolcat
            printf "\n";

            keep=10

            read -p "Clear old generations (keep $keep)? (y/n) [Y]: " choice
            if [[ "$choice" != "n" && "$choice" != "N" ]]; then
                sudo bash -c "nh clean all --keep $keep &> '$temp/nixos-clean.log'"
                sudo bash -c "nix-collect-garbage &>> '$temp/nixos-clean.log'"
            fi
        fi

    else sudo nixos-rebuild switch --upgrade --flake "$usr/.flake" --impure; fi
fi

# Disk optimizations
if [[ -n "$diskopt" ]]; then
    sudo nix-collect-garbage -d
    sudo fstrim -a
fi