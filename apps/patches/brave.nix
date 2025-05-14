{ config, pkgs, ... }:

let

    brave-patched = pkgs.writeShellScriptBin "brave" ''

        exec ${pkgs.brave}/bin/brave \
            --user-data-dir="/mnt/secondary/Data/brave" \
            "$@"
    '';

    #--disable-gpu-compositing \
    #--enable-features=UseOzonePlatform \
    #--ozone-platform=wayland 

    brave-patched-desktop = pkgs.makeDesktopItem {

        name = "brave-patched";
        exec = "brave";
        icon = "brave";
        desktopName = "Brave";
    };
in

{
    environment.systemPackages = with pkgs; [
        
        brave-patched
        brave-patched-desktop
    ];        
}