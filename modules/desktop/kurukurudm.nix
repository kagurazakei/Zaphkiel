{
  pkgs,
  config,
  users,
  lib,
  inputs,
  ...
}:
let
  uwuToHypr = pkgs.runCommandLocal "quick" { } ''
    awk '/^export/ { split($2, ARR, "="); print "env = "ARR[1]","ARR[2]}' ${../../dots/uwsm/env} > $out
  '';

  # Set wallpaper
  listening = pkgs.fetchurl {
    name = "tanjiro";
    url = "https://github.com/kagurazakei/wallpapers/blob/main/1215947.jpg";
    hash = "sha256-qXmnbhICMJ/I3phWt9cRT1EaxyT591r4n5TgvrAxhNI=";
  };

in
{
  imports = [ inputs.zaphkiel.nixosModules.kurukuruDM ];

  options.kagurazakei.desktop.kurukurudm.enable = lib.mkEnableOption "rex's desktop manager";

  config =
    lib.mkIf (config.kagurazakei.desktop.kurukurudm.enable && config.kagurazakei.desktop.enable)
      {

        # Rex's DM so I don't have problems with fprintd
        programs.kurukuruDM = {
          enable = true;
          settings = {
            wallpaper = listening;
            default_user = builtins.elemAt users 0;
            instantAuth = false;
            extraConfig = ''
              monitor = DP-1, 2160, 1440, 1
              monitor = DP-2, 1920x1080, 0x0, 1
              # night light
              exec-once = wlsunset -T 3000 -t 2999
              source = ${uwuToHypr}
            '';
          };
        };
      };
}
