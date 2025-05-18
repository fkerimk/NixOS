{ config, lib, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {

        kernelParams = [

            "nvidia-uvm.modeset=1"
            "nvidia-drm.modeset=1"
        ];

        kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };

    hardware = {

        graphics = {

            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                
                vaapiVdpau
                libvdpau
                libva
                nvidia-vaapi-driver
            ];
        };

        nvidia = {

            open = false;

            package = config.boot.kernelPackages.nvidiaPackages.beta;
            
            modesetting.enable = true;
            nvidiaSettings = true;

            powerManagement = {

                enable = false;
                finegrained = false;
            };
        };
    };

}
