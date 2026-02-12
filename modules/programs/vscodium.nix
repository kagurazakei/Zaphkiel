{
  pkgs,
  config,
  lib,
  ...
}:
{

  options.kagurazakei.programs.vscodium.enable = lib.mkEnableOption "vscodium";

  config =
    lib.mkIf (config.kagurazakei.programs.vscodium.enable && config.kagurazakei.programs.enable)
      {
        programs.vscode = {
          enable = true;
          package = pkgs.vscodium;
        };
      };
}
