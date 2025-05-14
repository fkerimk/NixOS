{ config, lib, pkgs, ... }:

{
    hardware.enableRedistributableFirmware = true;
    networking.interfaces.wlp45s0f3u4.useDHCP = true;
}