{
  pkgs,
  lib,
  config,
  ...
}:
{

  options.kagurazakei.programs.dolphin.enable = lib.mkEnableOption "dolphin";

  config =
    lib.mkIf (config.kagurazakei.programs.dolphin.enable && config.kagurazakei.programs.enable)
      {
        hjem.users.antonio = {
          packages = with pkgs.kdePackages; [
            dolphin
            dolphin-plugins
            gwenview
            ark
            kservice
            kde-cli-tools
            ffmpegthumbs
            kio
            kio-extras
            kio-fuse
            kimageformats
            kdegraphics-thumbnailers
            kirigami
          ];
        };

      };
}
