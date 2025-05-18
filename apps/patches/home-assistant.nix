{ config, lib, pkgs, ... }:

{
    services.home-assistant = {

        enable = true;

        config = {

            extraPackages = with pkgs.python3Packages; [

                gtts
            ];

            customComponents = with pkgs.home-assistant-custom-components; [
                
                xiaomi_miot
            ];

            homeassistant = {

                name = "Home";
                #latitude = "!secret latitude";
                #longitude = "!secret longitude";
                #elevation = "!secret elevation";
                unit_system = "metric";
                time_zone = "Europe/Istanbul";

            };

            frontend = {

                #themes = "!include_dir_merge_named themes";
            };

            http = {};

            feedreader.urls = [ "https://nixos.org/blogs.xml" ];

        };
    };
}