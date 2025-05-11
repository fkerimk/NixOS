{ config, pkgs, ... }:

{
    
    imports = [

        ./devices/nvidia.nix
        ./devices/wifi.nix
        ./hyprland.nix
        ./apps/apps.nix
        ./fonts.nix
    ];

    services.displayManager.sddm.enable = true;

    environment.systemPackages = with pkgs; [

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

        wl-clipboard
        wtype
    ];

}
