{ config, pkgs, ... }:

let

    tor-browser-patched = pkgs.writeShellScriptBin "tor-browser" ''

        exec ${pkgs.tor-browser}/bin/tor-browser \
            -profile "/mnt/secondary/Data/tor-browser" \
            "$@"
    '';

    tor-browser-patched-desktop = pkgs.makeDesktopItem {

        name = "tor-browser-patched";
        exec = "tor-browser";
        icon = "tor-browser";
        desktopName = "Tor Browser";
    };
in

{
    environment.systemPackages = with pkgs; [
        
        tor-browser-patched
        tor-browser-patched-desktop
    ];        
}