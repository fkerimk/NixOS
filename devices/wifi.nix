{ config, pkgs, ... }:

{
    networking = {

        networkmanager = {

            enable = true;
            wifi.backend = "iwd";
        };
    };

    boot.extraModulePackages = with config.boot.kernelPackages; [
        
        rtl88xxau-aircrack
    ];

    environment.systemPackages = with pkgs.linuxKernel.packages.linux_6_6; [

        rtl8812au
        rtl8821au
    ];

    hardware.enableRedistributableFirmware = true;
}