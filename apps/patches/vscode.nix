{ config, pkgs, ... }:

let

    vscode-patched = pkgs.writeShellScriptBin "code" ''

        exec ${pkgs.vscode}/bin/code \
            --no-sandbox \
            --user-data-dir "/mnt/secondary/Data/vscode" \
            "$@"
    '';

    #--disable-gpu-sandbox \
    #--disable-gpu-compositing \
    #--enable-features=UseOzonePlatform \
    #--enable-features=WaylandWindowDecorations \
    #--ozone-platform=wayland 

    vscode-patched-desktop = pkgs.makeDesktopItem {

        name = "vscode-patched";
        exec = "code";
        icon = "code";
        desktopName = "VSCode";
    };
in

{
    environment.systemPackages = with pkgs; [
        
        vscode-patched
        vscode-patched-desktop
    ];        
}