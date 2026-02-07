{
  self,
  sources,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) genAttrs nixosSystem;
  mkHost =
    hostName:
    nixosSystem {
      specialArgs = {
        inherit inputs sources;
        users = [ "antonio" ];
      };
      modules = [
        ./${hostName}/configuration.nix
        ./${hostName}/hardware-configuration.nix
        ../modules

        # Import zaphkiel packages from flake
        (
          {
            pkgs,
            inputs,
            ...
          }:
          {
            nixpkgs.overlays = [
              (_: _: {
                zpkgs = inputs.zaphkiel.packages.${pkgs.stdenv.hostPlatform.system};
                wo = self.packages.${pkgs.stdenv.hostPlatform.system};
              })
            ];
          }
        )
      ];
    };

  hosts = [
    "hana"
    "desktop"
  ];
in
genAttrs hosts mkHost
