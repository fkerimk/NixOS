{ config, lib, pkgs, ... }:

{
    nixpkgs.overlays = [
        
        (final: prev: {
            
            kdePackages = prev.kdePackages // {

                kwallet = final.stdenv.mkDerivation {
                    name = "kwallet-dummy";
                    phases = [ "installPhase" ];
                    installPhase = "mkdir -p $out";
                };

                kwallet-pam = final.stdenv.mkDerivation {
                    name = "kwallet-pam-dummy";
                    phases = [ "installPhase" ];
                    installPhase = "mkdir -p $out";
                };
            };

            libsForQt5 = prev.libsForQt5 // {

                kwallet = final.stdenv.mkDerivation {
                    name = "kwallet-qt5-dummy";
                    phases = [ "installPhase" ];
                    installPhase = "mkdir -p $out";
                };

                kwallet-pam = final.stdenv.mkDerivation {
                    name = "kwallet-pam-qt5-dummy";
                    phases = [ "installPhase" ];
                    installPhase = "mkdir -p $out";
                };
            };
        })
    ];
}