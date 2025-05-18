{ config, lib, pkgs, ... }:

{
    programs.obs-studio = {

        enable = true;

        package = pkgs.obs-studio.override {

            ffmpeg = pkgs.ffmpeg-full;
        };

        enableVirtualCamera = true;

        plugins = with pkgs.obs-studio-plugins; [

            obs-backgroundremoval
        ];
    };

}