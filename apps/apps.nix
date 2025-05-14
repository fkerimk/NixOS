{ config, lib, pkgs, ... }:

{
    imports = [

        ./patches/brave.nix
        ./patches/tor-browser.nix
        ./patches/vscode.nix
        ./patches/obs.nix
        ./patches/brave.nix
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
        mpv-unwrapped
        davinci-resolve
        stash
        textadept
        image-roll
        file-roller
        p7zip
        unrar
        nemo-fileroller
        gimp-with-plugins
        qdirstat
    ];

    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;

    services.home-assistant = {

        enable = true;

        config = {

            homeassistant = {

                name = "Home";
                #latitude = "!secret latitude";
                #longitude = "!secret longitude";
                #elevation = "!secret elevation";
                unit_system = "metric";
                time_zone = "GMT+3";

            };

            frontend = {

                #themes = "!include_dir_merge_named themes";
            };

            http = {};

            feedreader.urls = [ "https://nixos.org/blogs.xml" ];
        };
    };
}