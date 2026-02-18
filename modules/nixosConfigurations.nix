# ╭──────────────────────────────────────────────────────────╮
# │ add inputs as specialargs for using silent-sddm weid error                                                          │
# ╰──────────────────────────────────────────────────────────╯
{
  nixpkgs,
  self,
  ...
}@inputs:
let
  inherit (nixpkgs.lib) genAttrs nixosSystem attrNames;

  mkHost =
    hostName:
    nixosSystem {
      specialArgs = {
        inherit self nixpkgs inputs;
        users = [ "antonio" ];
        username = "antonio";
      };
      modules = [ self.azalea.hosts.${hostName} ];
    };
  hosts = attrNames self.azalea.hosts;
in
{
  nixosConfigurations = genAttrs hosts mkHost;
}
