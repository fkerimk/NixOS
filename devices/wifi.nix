{ config, lib, pkgs, ... }:

{
    networking.networkmanager.enable = true;

    boot.extraModulePackages = with config.boot.kernelPackages; [
        
        rtl88xxau-aircrack
    ];

    hardware.enableRedistributableFirmware = true;
}