{ config, pkgs, ... }:

{
    
    imports = [

        ./patches/brave.nix
        ./patches/obs.nix
    ];

    environment.systemPackages = with pkgs; [
        
        bitwarden-desktop
        ente-auth

        alacritty
        nemo-with-extensions

        vscode

        easyeffects
        qpwgraph
    ];

    programs.git.enable = true;
}