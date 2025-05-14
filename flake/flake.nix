{
    description = "Flake";

    inputs = {

        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixos-cachyos-kernel.url = "github:drakon64/nixos-cachyos-kernel";
    };

    outputs = {

        self,
        nixpkgs,
        nixos-cachyos-kernel,
    }:
    {
    nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          modules = [
            /etc/nixos/configuration.nix
            nixos-cachyos-kernel.nixosModules.default
          ];
        };
      };
    };
}