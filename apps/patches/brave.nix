{ config, pkgs, ... }:

let

    brave-patched = pkgs.writeShellScriptBin "brave" ''

        usr=$(eval echo "~$SUDO_USER")
        dat="$usr/Data/brave"

        exec ${pkgs.brave}/bin/brave \
            --user-data-dir="$dat" \
            --disable-gpu-compositing \
            --enable-features=UseOzonePlatform \
            --ozone-platform=wayland "$@"
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