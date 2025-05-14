{ config, lib, pkgs, ... }:

{
    programs.steam = {

        enable = true;
        extest.enable = true;

        package = pkgs.steam.override {

            extraEnv = {

                MANGOHUD = true;
                OBS_VKCAPTURE = true;
                RADV_TEX_ANISO = 16;
            };

            extraLibraries = p: with p; [

                atk
            ];
        };

        extraCompatPackages = with pkgs; [

            proton-ge-bin
        ];
    };
}