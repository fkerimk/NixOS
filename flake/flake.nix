{
    description = "Flake";

    inputs = {

        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    outputs = { self, nixpkgs, chaotic, ... } : {

        nixosConfigurations = {

            nixos = nixpkgs.lib.nixosSystem {

                modules = [
                    
                    /etc/nixos/configuration.nix
                    chaotic.nixosModules.default
                ];
            };
        };
    };
}