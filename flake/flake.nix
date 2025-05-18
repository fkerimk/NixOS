{
    description = "Flake";

    inputs = {

        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
        zen-browser.url = "github:kbwhodat/zen-browser-flake";
    };

    outputs = {
        
        self,
        nixpkgs,
        chaotic,
        zen-browser,
        
        ... 
        
    } : {

        nixosConfigurations = {

            nixos = nixpkgs.lib.nixosSystem {

                system = "x86_64-linux";

                modules = [
                    
                    /etc/nixos/configuration.nix

                    chaotic.nixosModules.default

                    ({ pkgs, ... }: {

                        environment.systemPackages = [

                            zen-browser.packages.x86_64-linux.default
                        ];
                    })

                ];
            };
        };
    };
}