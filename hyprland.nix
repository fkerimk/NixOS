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
    };

    services = {

        xserver = {

            enable = true;
            
            desktopManager = {

                xfce.enable = true;
                gnome.enable = false;
                plasma5.enable = false;
            };

            windowManager.hypr.enable = true;
        };

        desktopManager.plasma6.enable = false;
    };

    # Packages
    environment.systemPackages = with pkgs; [

        waybar               # Top bar
        hyprpolkitagent      # Polkit
        libnotify            # Notifications
        mako                 # Notifications
        mpvpaper             # Video wallpaper
        rofi-wayland         # Rofi
        hyprpicker           # Color picker
        hyprshot             # Screenshot
    ];
}
