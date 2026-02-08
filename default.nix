# DEFUNCT, PLEASE VIEW hosts/default.nix FOR SYSTEM BUILDING
# To build systems
# sudo nixos-rebuild --no-reexec --file ./default.nix -A <hostname> <boot|test|switch...>
let
  inherit (builtins) mapAttrs;
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  nixosConfig = import (sources.nixpkgs + "/nixos/lib/eval-config.nix");

  zaphkiel = import sources.zaphkiel {
    inherit sources pkgs;
  };

in
{

  hana = nixosConfig {
    system = null;
    specialArgs = {
      inherit sources zaphkiel;
      users = [ "antonio" ];
    };

    modules = [
      ./hosts/hana/configuration.nix
      ./hosts/hana/hardware-configuration.nix
    ];
  };

  desktop = nixosConfig {
    system = null;
    specialArgs = {
      inherit sources zaphkiel;
      users = [ "antonio" ];
    };

    modules = [
      ./hosts/desktop/configuration.nix
      ./hosts/desktop/hardware-configuration.nix
    ];
  };
}
