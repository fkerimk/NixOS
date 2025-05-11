{ config, lib, pkgs, ... }:

{
    hardware.enableRedistributableFirmware = true;

    boot.extraModulePackages = with config.boot.kernelPackages; [
        
        rtl88xxau-aircrack
    ];

    networking.interfaces.wlp45s0f3u4.useDHCP = true;
}