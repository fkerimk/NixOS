{ config, lib, pkgs, ... }:

{
    imports = [

        ./patches/brave.nix
        ./patches/vscode.nix
        ./patches/obs.nix
        ./mime.nix
    ];

    environment.systemPackages = with pkgs; [
        
        bitwarden-desktop
        ente-auth
        alacritty
        nemo-with-extensions
        easyeffects
        qpwgraph
        unityhub
        jetbrains.rider
        lutris-unwrapped
        gnome-font-viewer
        kdePackages.kdenlive
        mpv-unwrapped
    ];

    programs.steam = {

        enable = true;
        extest.enable = true;

        package = pkgs.steam.override {

            extraEnv = {

                MANGOHUD = true;
                OBS_VKCAPTURE = true;
                RADV_TEX_ANISO = 16;
            };

            extraLibraries = p: with p; [

                atk
            ];
        };

        extraCompatPackages = with pkgs; [

            proton-ge-bin
        ];
    };

    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;
}