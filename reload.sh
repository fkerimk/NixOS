#!/usr/bin/env bash

while getopts "hbrgn" opt; do
    case ${opt} in
        h)
            echo "-b : rebuild NixOS" 
            echo "-n : NixOS only" 
            echo "-r : do not hide messages" 
            echo "-g : disk optimizations" 
            exit 1 ;;
        b) build=true ;;
        r) raw=true ;;
        g) diskopt=true ;;
        n) nixOnly=true ;;
        \?) exit 1 ;;
        :) exit 1 ;;
    esac
done

if ! sudo -v; then exit 1; fi

echo "Reloading ..."

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
usr=$(eval echo "~$SUDO_USER")
nix="/etc/nixos"
tmp="$dir/temp"

if [[ -z "$nixOnly" ]]; then

    # Clone hyprland config
    [ -d "$usr/.config/hypr" ] && sudo rm -rf "$usr/.config/hypr";
    cp -r "$dir/config/hypr" "$usr/.config/hypr";
    hyprctl reload > /dev/null 2>&1 &

    # Clone waybar config
    [ -d "$usr/.config/waybar" ] && sudo rm -rf "$usr/.config/waybar";
    cp -r "$dir/config/waybar" "$usr/.config/waybar";
    sudo mv "$usr/.config/waybar/config.jsonc" "$usr/.config/waybar/config"
    killall .waybar-wrapped; nohup waybar 2>/dev/null &

    # Clone bash config
    [ -f "$usr/.bashrc" ] && sudo rm -f "$usr/.bashrc";
    cp "$dir/config/.bashrc" "$usr/.bashrc";
    source "$usr/.bashrc"

    # Clone alacritty config
    [ -d "$usr/.config/alacritty" ] && sudo rm -rf "$usr/.config/alacritty";
    mkdir -p "$usr/.config/alacritty"
    cp "$dir/config/alacritty.toml" "$usr/.config/alacritty/alacritty.toml";

    # Clone nemo config
    [ -d "$usr/.local/share/nemo/actions" ] && sudo rm -rf "$usr/.local/share/nemo/actions";
    cp -r "$dir/config/nemo" "$usr/.local/share/nemo/actions"
fi

# Clone flake
[ -d "$usr/.flake" ] && sudo rm -rf "$usr/.flake";
mkdir -p "$usr/.flake"
cp "$dir/flake.nix" "$usr/.flake/flake.nix";

if [[ -n "$build" ]]; then
    
    echo "NixOS Rebuilding..."

    if [[ -z "$raw" ]]; then 
    
        sudo bash -c "sudo nixos-rebuild switch --upgrade --flake "$usr/.flake" --impure &>'$tmp/nixos-switch.log'"; 

        if grep -q 'error:' "$tmp/nixos-switch.log"; then
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
            "$tmp/nixos-switch.log" \
            | sed 's/^[ \t]*//;s/[ \t]*$//' \
            | sed -E \
                -e 's/error:/\x1b[31m&\x1b[0m/g' \
                -e 's/at /\x1b[34m&\x1b[0m/g' \
            | cat \
            | boxes -d tux
            exit 1
        else
            figlet -f "/home/furkan/NixOS/scripts/figlett/fonts/Rozzo.flf" DONE | boxes -d parchment | lolcat
            printf "\n";
        fi

    else sudo nixos-rebuild switch --upgrade --flake "$usr/.flake" --impure; fi
fi

# Disk optimizations
if [[ -n "$diskopt" ]]; then
    sudo nh clean all
    sudo nix-store --optimise
    sudo nix-collect-garbage -d
    #sudo fstrim -a
fi