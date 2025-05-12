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
            
            desktopManager = {

                xfce.enable = true;
                
                gnome.enable = false;
                plasma5.enable = false;
            };

            windowManager.hypr.enable = true;
        };

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

        hyprpolkitagent      # Polkit
        libnotify            # Notifications
        mako                 # Notifications
        mpvpaper             # Video wallpaper
        rofi-wayland         # Rofi
        hyprcursor           # Cursor
        rose-pine-hyprcursor # Cursor theme
        hyprpicker           # Color picker
        hyprshot             # Screenshot
    ];

    # Sound
    security.rtkit.enable = true;

    # Disable KDE polkit
    systemd.user.services.polkit-kde-authentication-agent-1.enable = false;
}
