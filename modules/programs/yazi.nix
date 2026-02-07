{
  pkgs,
  config,
  lib,
  users,
  ...
}:
let
  dot = config.hjem.users.antonio.impure.dotsDir;
in
{
  options.kagurazakei.programs.yazi.enable = lib.mkEnableOption "yazi";
  config = lib.mkIf (config.kagurazakei.programs.yazi.enable && config.kagurazakei.programs.enable) {
    environment.systemPackages = [ pkgs.yazi ];
  };
}
