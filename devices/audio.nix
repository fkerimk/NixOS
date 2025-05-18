{ config, pkgs, ... }:

{
    services.pipewire = {

        enable = true;

        jack.enable = true;
        audio.enable = true;
        pulse.enable = true;

        alsa = {
            
            enable = true;
            support32Bit = true;
        };
    };

    security.rtkit.enable = true;

    environment.systemPackages = [

        pkgs.alsa-utils
    ];

}