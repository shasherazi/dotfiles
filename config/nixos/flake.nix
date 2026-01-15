{
  description = "Hopefully my main flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      mkHost =
        hostConfigPath:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            hostConfigPath
            ./modules/shared
          ];
        };
    in
    {
      nixosConfigurations = {
        shtinkbook = mkHost ./shtinkbook/configuration.nix;
        shtinkpad = mkHost ./shtinkpad/configuration.nix;
      };
    };
}
