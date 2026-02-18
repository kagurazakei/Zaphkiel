{
  nixpkgs,
  self,
  ...
}:
let
  inherit (nixpkgs.lib) genAttrs nixosSystem attrNames;

  mkHost = hostName: nixosSystem { modules = [ self.azalea.hosts.${hostName} ]; };
  hosts = attrNames self.azalea.hosts;
in
{
  nixosConfigurations = genAttrs hosts mkHost;
}
