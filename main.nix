{ config, lib, pkgs, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;

    services.displayManager.sddm.enable = true;

    imports = [

        ./libs.nix
        
        ./devices/nvidia.nix
        ./devices/audio.nix
        ./devices/wifi.nix
        ./devices/mount.nix

        ./hyprland.nix

        ./apps/apps.nix

        ./fonts.nix
        
    ];

    environment.systemPackages = with pkgs; [
        
        lolcat
        clolcat
        boxes
        figlet
        numbat
        btop
        bemoji
        fastfetch
        sl
        ponysay
        asciiquarium-transparent
        asciidoctor-with-extensions
        libsForQt5.kdenlive
    ];

    programs.nh.enable = true;

    users.users.furkan = {
        
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };
}