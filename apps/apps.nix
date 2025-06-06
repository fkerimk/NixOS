{ config, lib, pkgs, ... }:

{
    imports = [

        ./libs.nix
        
        ./patches/brave.nix
        ./patches/tor-browser.nix
        ./patches/vscode.nix
        ./patches/obs.nix
        ./patches/brave.nix
        ./patches/steam.nix
        ./patches/zapret.nix
        ./patches/zen-browser.nix
        ./patches/openshot.nix

        ./mime.nix
    ];

    environment.systemPackages = with pkgs; [

        bitwarden-desktop
        ente-auth
        alacritty
        nemo-with-extensions
        qpwgraph
        unityhub
        jetbrains.rider
        lutris-unwrapped
        gnome-font-viewer
        mpv-unwrapped
        stash
        textadept
        image-roll
        file-roller
        nemo-fileroller
        gimp-with-plugins
        qdirstat
        nwg-look
        easyeffects
        bottles-unwrapped
        wineWowPackages.waylandFull
        minecraft
        mcpelauncher-ui-qt
        uget
        ferdium
        audacity
    ];
    
    programs.localsend.enable = true;

    #programs.kdeconnect.enable = true;
    #programs.partition-manager.enable = true;

    programs.thunderbird.enable = true;
}