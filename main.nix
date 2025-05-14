{ config, lib, pkgs, ... }:

{
    nix.settings = {
        
        substituters = [ "https://drakon64-nixos-cachyos-kernel.cachix.org" ];
        trusted-public-keys = [ "drakon64-nixos-cachyos-kernel.cachix.org-1:J3gjZ9N6S05pyLA/P0M5y7jXpSxO/i0rshrieQJi5D0=" ];
    };

    boot.kernelPackages = with pkgs; linuxPackagesFor linuxPackages_cachyos;

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