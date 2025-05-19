{ config, lib, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
    boot.extraModulePackages = [ pkgs.linuxPackages_cachyos.nvidia_x11 ];

    services.displayManager.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = lib.mkForce false;
    services.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.gdm.enable = lib.mkForce false;
    services.xserver.displayManager.startx.enable = lib.mkForce false;

    services.getty.autologinUser = "furkan";

    imports = [

        ./libs.nix
        ./devices/nvidia.nix
        ./devices/audio.nix
        ./devices/wifi.nix
        ./devices/mount.nix
        ./hyprland.nix
        ./apps/apps.nix
        ./fonts.nix
        ./cleaner.nix
    ];

    environment.systemPackages = with pkgs; [
        
        lolcat
        clolcat
        boxes
        figlet
        numbat
        btop
        bemoji
        fastfetch
        sl
        ponysay
        asciiquarium-transparent
        asciidoctor-with-extensions

        clipgrab
    ];

    programs.nh.enable = true;

    users.users.furkan = {
        
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };

    environment.sessionVariables = {

        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NVD_BACKEND = "direct1";
        WLR_NO_HARDWARE_CURSORS = "1";
        LIBGL_ALWAYS_SOFTWARE = "0";
        GBM_BACKEND = "nvidia-drm";
        NIXOS_OZONE_WL = "1";
        #NVIDIA_DRIVER_CAPABILITIES = "compute,video,utility,graphics";
        NVIDIA_DRIVER_CAPABILITIES = "all";
        XDG_SESSION_TYPE = "wayland";
        #LIBVA_DRIVERS_PATH = "${pkgs.vaapiVdpau}/lib/dri:${pkgs.nvidia-vaapi-driver}/lib/dri";
        #VDPAU_DRIVER = "nvidia";
        #CUDA_VISIBLE_DEVICES = "0";
    };

   # environment.variables.LD_LIBRARY_PATH = lib.mkForce "/run/opengl-driver/lib:/run/opengl-driver-32/lib:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
}