{
  config,
  lib,
  pkgs,

  ...
}:
{
  options.kagurazakei.programs.fuzzel.enable = lib.mkEnableOption "fuzzel";
  config =
    lib.mkIf (config.kagurazakei.programs.fuzzel.enable && config.kagurazakei.programs.enable)
      {
        hjem.users.antonio = {
          packages = [ pkgs.fuzzel ];
        };
      };
}
