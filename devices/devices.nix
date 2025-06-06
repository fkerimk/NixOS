{ config, pkgs, ... }:

{
    imports = [

        ./nvidia.nix
        ./audio.nix
        ./wifi.nix
        ./mount.nix
    ];
}