{ config, lib, pkgs, ... }:

{
    nixpkgs.config.packageOverrides = super: {

        nixpkgs.overlays = [

            (final: prev: {

                ffmpeg = prev.ffmpeg-full.override {
                    withCuda = true;
                };
            })
        ];
    };

    environment.systemPackages = with pkgs; [

        adwaita-qt
        libsForQt5.breeze-gtk
        gtk4
        gtk3
        wl-clipboard
        wtype
        fzf
        killall
        p7zip
        unrar
        movit
        ffmpeg
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
        libglvnd
        cudaPackages.cudatoolkit
        libGL
        libGLU
        nvidia-vaapi-driver
        vdpauinfo
        libva-utils
        glxinfo
        libnvidia-container
        nv-codec-headers-12
        x264
        mono
        dotnet-sdk
        vaapiVdpau
        libvdpau
        libva
        libsForQt5.mlt
        mlt
        removeReferencesTo
        gnused
        appimage-run
        wget

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
        mimeo
        clipgrab
    ];
}