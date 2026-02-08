{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    inputs.noctalia.nixosModules.default
  ];

  options.kagurazakei.desktop.hypridle.enable = lib.mkEnableOption "hypridle";

  config =
    lib.mkIf (config.kagurazakei.desktop.hypridle.enable && config.kagurazakei.desktop.enable)
      {
        services.hypridle = {
          enable = true;
        };
        # Fix paths
        systemd.user.services.hypridle.path = lib.mkForce (
          lib.attrValues {
            inherit (pkgs) brightnessctl systemd;
            hyprlock = config.programs.hyprlock.package;
            hyprland = config.programs.hyprland.package;
            niri = config.programs.niri.package;
            noctalia = config.services.noctalia-shell.package;
          }
        );
      };
}
