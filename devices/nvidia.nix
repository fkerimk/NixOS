{ config, lib, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {

        kernelParams = [

            "nvidia-drm.modeset=1"
        ];

        kernelModules = [

            "nvidia"
            
            "nvidia-drm"
            "nvidia-uvm"
            "nvidia-modeset"

            "nvidia_drm"
            "nvidia_uvm"
            "nvidia_modeset"
        ];
    };

    hardware = {

        graphics.enable = true;

        nvidia = {

            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            modesetting.enable = true;
            nvidiaSettings = true;

            powerManagement = {

                enable = false;
                finegrained = false;
            };
        };
    };

    environment.systemPackages = with pkgs; [

        libglvnd
    ];
}
