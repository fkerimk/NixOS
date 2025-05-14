{ config, lib, pkgs, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

    imports = [

        ./devices/nvidia.nix
        ./devices/audio.nix
        ./devices/wifi.nix
        ./devices/mount.nix

        ./hyprland.nix

        ./apps/apps.nix
        ./dpi-bypass.nix

        ./fonts.nix
        
    ];

    services.displayManager.sddm.enable = true;

    environment.systemPackages = with pkgs; [

        killall
        nwg-look
        adwaita-qt
        gtk4
        gtk3
        lolcat
        clolcat
        boxes
        figlet
        numbat
        btop
        bemoji
        wl-clipboard
        wtype
        fzf

        fastfetch
        sl
        ponysay

        toilet

        asciiquarium-transparent
        
        asciidoctor-with-extensions

    ];

    programs.nh.enable = true;
}