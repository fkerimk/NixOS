#!/usr/bin/env fish

#  ██████╗ ███████╗███╗   ██╗███████╗██████╗ ██╗ ██████╗
# ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██║██╔════╝
# ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝██║██║
# ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██║██║
# ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║╚██████╗
#  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝

# ▄ ▄▖▄▖▖▖▄▖▄▖▄▖▖▖▖ ▖▄   ▄▖▄▖▄▖▄▖
# ▙▘▌▌▌ ▙▘▌ ▙▘▌▌▌▌▛▖▌▌▌  ▌▌▙▌▙▌▚
# ▙▘▛▌▙▖▌▌▙▌▌▌▙▌▙▌▌▝▌▙▘  ▛▌▌ ▌ ▄▌

streamdeck -n &
fdm --hidden &
qbittorrent &
ferdium &
slack --password-store=gnome -u &
bauh --tray &
kdeconnectd &
kalarm --tray &

easyeffects &

switch $XDG_CURRENT_DESKTOP

    # ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗
    # ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
    # ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
    # ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
    # ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
    # ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝

    case 'Hyprland'

        # ▖  ▖▄▖▖▖▄ ▄▖▄▖
        # ▌▞▖▌▌▌▌▌▙▘▌▌▙▘
        # ▛ ▝▌▛▌▐ ▙▘▛▌▌▌

        waybar &

        # ▖  ▖▄▖▖ ▖ ▄▖▄▖▄▖▄▖▄▖
        # ▌▞▖▌▌▌▌ ▌ ▙▌▌▌▙▌▙▖▙▘
        # ▛ ▝▌▛▌▙▖▙▖▌ ▛▌▌ ▙▖▌▌

        swww-daemon &
        mpvpaper -o "no-audio loop" DP-3 /home/fkerimk/.config/wallpapers/main-wp.mp4 &

        # ▄▖▖▖▄▖▄▖▖  ▖▄▖▄▖▄▖▄▖▖ ▖
        # ▌▌▌▌▐ ▌▌▛▖▞▌▌▌▐ ▐ ▌▌▛▖▌
        # ▛▌▙▌▐ ▙▌▌▝ ▌▛▌▐ ▟▖▙▌▌▝▌

        # Prewarm system
        mako &
        bash -c "mkfifo /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob && tail -f /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob | wob & disown" &
        /usr/lib/polkit-kde-authentication-agent-1 &
        #nm-applet --indicator &
        #fcitx5 -d &

        # Fix slow app launching
        systemctl --user import-environment &
        hash dbus-update-activation-environment 2>/dev/null &
        dbus-update-activation-environment --systemd &

        # Auto select workspace 2
        hyprctl dispatch workspace 2

end

