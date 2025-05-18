{ config, lib, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {

        kernelParams = [

            "nvidia-uvm.modeset=1"
            "nvidia-drm.modeset=1"
            "nvidia.Nvreg_EnableGpuFirmware=1"
            "Nvreg_EnableGpuFirmware=1"
            "nvidia.NVreg_UsePageAttributeTable=1"
            "nvidia.NVreg_EnableStreamMemOPs=1"
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
                libvdpau-va-gl
            ];
        };

        nvidia = {

            open = false;

            package = pkgs.linuxPackages_cachyos.nvidia_x11;

            nvidiaSettings = true;
            modesetting.enable = true;
            nvidiaPersistenced = true;

            powerManagement = {

                enable = false;
                finegrained = false;
            };
        };
    };

    #environment.sessionVariables.LD_LIBRARY_PATH = lib.mkForce "${pkgs.linuxPackages_cachyos.nvidia_x11}/lib";
}
