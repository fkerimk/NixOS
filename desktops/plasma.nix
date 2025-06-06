{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [

        libsForQt5.kde-cli-tools
        libsForQt5.plasma-desktop
    ];
}