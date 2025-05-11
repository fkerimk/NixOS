#!/usr/bin/env fish

# ███╗   ███╗███████╗███╗   ██╗██╗   ██╗███████╗
# ████╗ ████║██╔════╝████╗  ██║██║   ██║██╔════╝
# ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║███████╗
# ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║╚════██║
# ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝███████║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

# ▖  ▖▄▖▄▖▖ ▖
# ▛▖▞▌▌▌▐ ▛▖▌
# ▌▝ ▌▛▌▟▖▌▝▌

function main_menu

    echo "󱓞  Run"
    echo "  Search"
    echo "  Unity"
    echo "  Config"
    echo "  Reboot"
    echo "󰖩  WiFi"
    echo "  TDK"
    echo "󰧴  Nerd Fonts"

end

# ▖▖▖ ▖▄▖▄▖▖▖
# ▌▌▛▖▌▐ ▐ ▌▌
# ▙▌▌▝▌▟▖▐ ▐

function unity_menu

    echo "  Back"
    echo "  Unity Hub"
    echo "󰀼  Assets"

end

# ▄▖▄▖▖ ▖▄▖▄▖▄▖
# ▌ ▌▌▛▖▌▙▖▐ ▌
# ▙▖▙▌▌▝▌▌ ▟▖▙▌

function config_menu

    echo "  Back"
    echo "  Global"
    echo "  Mimeapps"
    echo "  Scripts"
    echo "  Hyprland"
    echo "  Rofi"
    echo "  SDDM"

end


# ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
# ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
# █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
# ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
# ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

set main_choice (main_menu | rofi -dmenu -p "Main" -i)

switch $main_choice

    # ▖  ▖▄▖▄▖▖ ▖
    # ▛▖▞▌▌▌▐ ▛▖▌
    # ▌▝ ▌▛▌▟▖▌▝▌

    case "  TDK"; nohup ~/.config/rofi/scripts/rofi-tdk/rofi-tdk.sh > /dev/null 2>&1 & 
    case "󰖩  WiFi"; nohup ~/.config/rofi/scripts/rofi-wifi-menu.sh > /dev/null 2>&1 & 
    case "󱓞  Run"; nohup rofi -show drun -modi drun > /dev/null 2>&1 & 
    case "  Reboot"; reboot
    case "󰧴  Nerd Fonts"; nohup xdg-open "https://www.nerdfonts.com/cheat-sheet" > /dev/null 2>&1 & 
    case "  Search"; nohup fsearch > /dev/null 2>&1 &

    # ▄▖▄▖▖ ▖▄▖▄▖▄▖
    # ▌ ▌▌▛▖▌▙▖▐ ▌
    # ▙▖▙▌▌▝▌▌ ▟▖▙▌

    case "  Config"; 
    
        set config_choice (config_menu | rofi -dmenu -p "Config" -i)

        switch $config_choice

            case "  Back"; ~/.config/rofi/rofi.sh
            case "  Global"; nohup code ~/.config/ > /dev/null 2>&1 & 
            case "  Mimeapps"; nohup code ~/.config/scripts/mimeapps > /dev/null 2>&1 & 
            case "  Hyprland"; nohup code ~/.config/hypr/ > /dev/null 2>&1 & 
            case "  Scripts"; nohup code ~/.config/scripts/ > /dev/null 2>&1 & 
            case "  SDDM"; nohup code /usr/lib/sddm/sddm.conf.d/ /usr/share/sddm/themes/ > /dev/null 2>&1 & 
            case "  Rofi"; nohup code ~/.config/rofi/ > /dev/null 2>&1 & 

        end

    # ▖▖▖ ▖▄▖▄▖▖▖
    # ▌▌▛▖▌▐ ▐ ▌▌
    # ▙▌▌▝▌▟▖▐ ▐

    case "  Unity"; 

        set unity_choice (unity_menu | rofi -dmenu -p "Unity" -i)

        switch $unity_choice

            case "  Back"; ~/.config/rofi/rofi.sh
            case "  Unity Hub"; nohup unityhub > /dev/null 2>&1 &

            # ▄▖▄▖▄▖▄▖▄▖▄▖
            # ▌▌▚ ▚ ▙▖▐ ▚
            # ▛▌▄▌▄▌▙▖▐ ▄▌

            case "󰀼  Assets"; 

                set options_file "/tmp/rofi_options.txt"
                echo "  Back" > $options_file

                for file in (find "/run/media/fkerimk/Secondary M2/Unity/Assets" -maxdepth 1 -type f -exec basename {} \;)
                    set filename (string replace -r '\.([a-zA-Z0-9]+)$' '' $file)
                    echo "󰀼  $filename" >> $options_file
                end

                set assets_choice (rofi -dmenu -p "Assets" -i < $options_file)

                if test -n "$assets_choice"

                    if test "$assets_choice" = "  Back"; ~/.config/rofi/rofi.sh
                
                    else

                        set assets_choice (string replace -r "^󰀼  " "" $assets_choice)
                        set assets_choice "$assets_choice.unitypackage"
                        echo $assets_choice
                        set full_path "/run/media/fkerimk/Secondary M2/Unity/Assets/$assets_choice"
                        echo -n $full_path | wl-copy
                        notify-send "📋 Path copied!" "$assets_choice"

                    end

                end
                
        end
end
