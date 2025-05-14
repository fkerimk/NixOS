{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        fira
        nerd-fonts.fira-code
        nerd-fonts.hack
        nerd-fonts.overpass
        font-awesome
        roboto
    ];
}