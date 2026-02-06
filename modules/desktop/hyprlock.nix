{
  users,
  config,
  lib,
  pkgs,
  ...
}:
{

  options.kagurazakei.desktop.hyprlock.enable = lib.mkEnableOption "hyprlock";

  config =
    lib.mkIf (config.kagurazakei.desktop.hyprlock.enable && config.kagurazakei.desktop.enable)
      {

        # Hyprland screen locking utility
        programs.hyprlock.enable = true;

        # Set hyprlock dot file
        hjem.users = lib.genAttrs users (user: {
          files =
            let

              # Set hyprlock wallpaper
              hyprlockwall =
                let
                  from = [ "$_SCHIZOPHRENIA_$" ];
                  tanjiro = pkgs.fetchurl {
                    name = "tanjiro";
                    url = "https://github.com/kagurazakei/wallpapers/blob/main/1215947.jpg";
                    hash = "sha256-qXmnbhICMJ/I3phWt9cRT1EaxyT591r4n5TgvrAxhNI=";
                  };
                  to = [ "${tanjiro}" ];
                in
                builtins.replaceStrings from to (builtins.readFile ../../dots/hyprland/hyprlock.conf);

            in
            {
              ".config/hypr/hyprlock.conf".text = hyprlockwall;
            };
        });
      };
}
