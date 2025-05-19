{ config, pkgs, zen-browser, ... }:

let

    zen-patched = pkgs.writeShellScriptBin "zen" ''

        exec ${zen-browser.packages.x86_64-linux.default}/bin/zen \
            -profile "/mnt/secondary/Data/zen" \
            "$@"
    '';

    zen-patched-desktop = pkgs.makeDesktopItem {

        name = "zen-patched";
        exec = "zen";
        icon = "zen";
        desktopName = "Zen Browser";
    };
in

{
    environment.systemPackages = with pkgs; [
        
        zen-patched
        zen-patched-desktop
    ];        
}