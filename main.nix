{ config, pkgs, ... }:

{
    
    imports = [

        ./devices/nvidia.nix
        ./devices/wifi.nix
        ./hyprland.nix
        ./apps/apps.nix
        ./fonts.nix
    ];

    services = {

        xserver = {

            enable = true;
            desktopManager.xfce.enable = true;
        };

        displayManager.sddm.enable = true;
    };

    environment.systemPackages = with pkgs; [

        git

        killall

        nwg-look
        adwaita-qt
        gtk4
        gtk3

        clolcat
        boxes

        figlet
        nodePackages.insect

        btop

        bemoji
    ];

}
