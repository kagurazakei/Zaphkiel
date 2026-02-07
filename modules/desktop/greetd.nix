{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.kagurazakei.desktop.greetd.enable = lib.mkEnableOption "gnome display manager";

  config = lib.mkIf (config.kagurazakei.desktop.greetd.enable && config.kagurazakei.desktop.enable) {

    services = {
      colord.enable = true;
      greetd = {
        enable = true;
        settings = {
          initial_session = {
            user = "antonio";
            command = "uwsm start niri-uwsm.desktop";
          };
          default_session = {
            user = "greeter";
            command = "${pkgs.tuigreet}/bin/tuigreet --user-menu -w 50 --window-padding 7 --container-padding 7 --remember --remember-session --time --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd uwsm start niri-uwsm.desktop";
          };
        };
      };
    };

    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor manager by UWSM";
          binPath = "/run/current-system/sw/bin/start-hyprland";
        };
        niri = {
          prettyName = "Niri The Goat";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };

    };
  };
}
