{ config, pkgs, ... }:

let

    brave-patched = pkgs.writeShellScriptBin "brave" ''

        exec ${pkgs.brave}/bin/brave \
            --disable-gpu-compositing \
            --user-data-dir="/mnt/secondary/Data/brave" \
            --enable-features=UseOzonePlatform \
            --ozone-platform=wayland \
            "$@"
    '';
    
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