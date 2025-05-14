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
        hyprcursor           # Cursor
        rose-pine-hyprcursor # Cursor theme
        hyprpicker           # Color picker
        hyprshot             # Screenshot
    ];

    #environment.etc."xdg/autostart/polkit-kde-authentication-agent-1.desktop".text = ''
    #    [Desktop Entry]
    #    Hidden=true
    #'';

    # Disable KDE shit
    systemd.user.services.polkit-kde-authentication-agent-1.enable = false;

    nixpkgs.overlays = [
        (final: prev: {
            kdePackages = prev.kdePackages // {
                polkit-kde-agent = prev.runCommand "dummy-polkit-kde-agent" { } ''
                mkdir -p $out/bin
                echo "#!/bin/sh" > $out/bin/polkit-kde-authentication-agent-1
                chmod +x $out/bin/polkit-kde-authentication-agent-1
                '';
                kwallet = null;
                kwalletmanager = null;
            };
        })
    ];

    #services.kdeWallet.enable = false;
}
