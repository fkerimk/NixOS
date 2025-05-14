{ config, pkgs, ... }:

{
#    services = {
#
#        pipewire = {
#
#            alsa = {
#
#                enable = true;
#                support32Bit = true;
#            };
#
#            pulse.enable = true;
#        };
#
#        jack.alsa.support32Bit = true;
#    };

    services.pipewire.enable = false;

    services.pulseaudio = {

        enable = true;
    };

    security.rtkit.enable = true;

    environment.systemPackages = [

        pkgs.alsa-utils
    ];

}