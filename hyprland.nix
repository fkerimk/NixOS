{ config, pkgs, ... }:

{
    # Desktop portal
    xdg.portal = {

        enable = true;

        extraPortals = with pkgs; [
            
            xdg-desktop-portal-gtk
        ];
    };

    # Hyprland
    programs = {

        uwsm.enable = true;

        hyprland = {

            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };

        waybar.enable = true;
    };

    services = {

        xserver = {

            enable = true;
            windowManager.hypr.enable = true;
        }

        pipewire = {

            enable = true;

            alsa = {

                enable = true;
                support32Bit = true;
            };

            pulse.enable = true;
            jack.enable = true;
        };
    };

    # Packages
    environment.systemPackages = with pkgs; [

        # Polkit
        hyprpolkitagent

        # Notifications
        mako
        libnotify

        # Wallpaper
        mpvpaper

        # Rofi
        rofi-wayland

        # Cursor
        hyprcursor
        rose-pine-hyprcursor
    ];

    # Sound
    security.rtkit.enable = true;
}
