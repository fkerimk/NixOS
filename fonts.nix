
{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        
        fira
        nerdfonts
        font-awesome
        roboto
    ];
}