{ config, pkgs, ... }:

{
    security.rtkit.enable = true;

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

    environment.systemPackages = [

        pkgs.alsa-utils
    ];

}