{ config, pkgs, ... }:

let

    openshot-patched = pkgs.writeShellScriptBin "openshot-qt" ''

        QT_QPA_PLATFORM=xcb exec ${pkgs.openshot-qt}/bin/openshot-qt \
            "$@"
    '';
    
    openshot-patched-desktop = pkgs.makeDesktopItem {

        name = "openshot-patched";
        exec = "openshot-qt";
        icon = "openshot-qt";
        desktopName = "OpenShot";
    };
in

{
    environment.systemPackages = with pkgs; [
        
        openshot-patched
        openshot-patched-desktop
    ];        
}