{ config, lib, pkgs, ... }:

{
    networking.networkmanager.enable = true;
    hardware.enableRedistributableFirmware = true;
    networking.interfaces.wlp45s0f3u4.useDHCP = true;
}