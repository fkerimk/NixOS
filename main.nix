{ config, lib, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowBroken = true;

    boot = {

        kernelPackages = pkgs.linuxPackages_cachyos-lto;
        extraModulePackages = [ pkgs.linuxPackages_cachyos.nvidia_x11 ];
    };

    services = {

        displayManager = {

            enable = true;
            sddm.enable = true;
        };

        xserver.displayManager = {

            gdm.enable = lib.mkForce false;
            startx.enable = lib.mkForce false;
            lightdm.enable = lib.mkForce false;
        };

        getty.autologinUser = "furkan";
    };

    imports = [

        ./devices/devices.nix
        ./apps/apps.nix
        ./hyprland.nix
        ./desktops/plasma.nix
        ./fonts.nix
    ];

    programs.nh.enable = true;

    users.users.furkan.extraGroups = [ "wheel" "networkmanager" "video" ];

    environment.sessionVariables = {

        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        LIBGL_ALWAYS_SOFTWARE = "0";
        XDG_SESSION_TYPE = "wayland";
        GBM_BACKEND = "nvidia-drm";
        NVD_BACKEND = "direct1";
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
        NVIDIA_DRIVER_CAPABILITIES = "all";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
}