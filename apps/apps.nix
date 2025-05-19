{ config, lib, pkgs, ... }:

{
    nixpkgs.config.allowBroken = true;

    imports = [

        ./patches/brave.nix
        ./patches/tor-browser.nix
        ./patches/vscode.nix
        ./patches/obs.nix
        ./patches/brave.nix
        ./patches/steam.nix
        ./patches/zapret.nix
        ./patches/zen-browser.nix

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
        davinci-resolve
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
        kdePackages.kdenlive
    ];

    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;

    programs.thunderbird.enable = true;
}