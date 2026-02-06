{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{

  options.kagurazakei.programs.nvim.enable = mkEnableOption "nvim";
  config = mkIf (config.kagurazakei.programs.nvim.enable && config.kagurazakei.programs.enable) {
    environment.systemPackages = [ pkgs.zpkgs.xvim.default ];
  };
}
