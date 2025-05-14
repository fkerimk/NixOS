{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [ zapret ];

    services.zapret = {

        enable = true;

        params = [

            #"--hostspell=hoSt"
            #"--split-tls=sni"
            #"--oob"
            "--dpi-desync=fake"
            "--dpi-desync-ttl=3"
        ];
    };

    services.resolved.enable = false;

    networking = {
        
        resolvconf.enable = false;
        nameservers = [ "1.1.1.1" "8.8.8.8" ];
    };
}