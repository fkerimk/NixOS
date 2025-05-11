{ config, pkgs, ... }:

let
    brave_wayland = pkgs.writeShellScriptBin "brave" ''
        exec ${pkgs.brave}/bin/brave \
            --disable-gpu-compositing \
            --enable-features=UseOzonePlatform \
            --ozone-platform=wayland "$@"
    '';
in

# --disable-gpu-sandbox \
# --disable-gpu-compositing \
# --enable-features=UseOzonePlatform \
# --ozone-platform=wayland "$@"

{
    environment.systemPackages = with pkgs; [
        
        brave_wayland
    ];        
}