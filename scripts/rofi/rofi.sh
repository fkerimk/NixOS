#!/usr/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
usr=$(eval echo "~$SUDO_USER")
nix="$usr/NixOS"
tmp="$dir/temp"

main_menu() {

    echo "󱓞  Run"
    #echo "  Search"
    echo "  Unity"
    echo "  NixOS"
    echo "  TDK"
    echo "󰧴  Nerd Fonts"
}

unity_menu() {

    echo "  Back"
    echo "  Unity Hub"
    echo "󰀼  Assets"
}

main_choice=$(main_menu | rofi -dmenu -p "Main" -i)

case "$main_choice" in

    "  TDK") nohup "$dir/tdk/tdk.sh" > /dev/null 2>&1 & ;;
    "󱓞  Run") nohup rofi -show drun -modi drun > /dev/null 2>&1 & ;;
    "󰧴  Nerd Fonts") nohup xdg-open "https://www.nerdfonts.com/cheat-sheet" > /dev/null 2>&1 & ;;
    "  Search") nohup fsearch > /dev/null 2>&1 & ;;
    "  NixOS") nohup code $nix > /dev/null 2>&1 & ;;

    "  Unity")
        unity_choice=$(unity_menu | rofi -dmenu -p "Unity" -i)
        case "$unity_choice" in
            "  Back") ~/.config/rofi/rofi.sh ;;
            "  Unity Hub") nohup unityhub > /dev/null 2>&1 & ;;

            "󰀼  Assets")
                options_file="/tmp/rofi_options.txt"
                echo "  Back" > "$options_file"

                while IFS= read -r file; do
                    filename=$(basename "$file")
                    filename="${filename%.*}"
                    echo "󰀼  $filename" >> "$options_file"
                done < <(find "/run/media/fkerimk/Secondary M2/Unity/Assets" -maxdepth 1 -type f)

                assets_choice=$(rofi -dmenu -p "Assets" -i < "$options_file")

                if [ -n "$assets_choice" ]; then
                    if [ "$assets_choice" = "  Back" ]; then
                        ~/.config/rofi/rofi.sh
                    else
                        assets_choice="${assets_choice#󰀼  }"
                        assets_choice="$assets_choice.unitypackage"
                        full_path="/run/media/fkerimk/Secondary M2/Unity/Assets/$assets_choice"
                        echo -n "$full_path" | wl-copy
                        notify-send "📋 Path copied!" "$assets_choice"
                    fi
                fi
                ;;
        esac
        ;;
esac
