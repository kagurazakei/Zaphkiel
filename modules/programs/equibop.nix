{
  pkgs,
  lib,
  user,
  config,
  ...
}:
{

  options.kagurazakei.programs.equibop.enable = lib.mkEnableOption "equibop";

  config =
    lib.mkIf (config.kagurazakei.programs.equibop.enable && config.kagurazakei.programs.enable)
      {
        environment.systemPackages = [
          pkgs.equibop
          pkgs.arrpc
        ];
        hjem.users.antonio = {
          files = {
            ".config/equibop/setting.json".text = ''
              {
                     "MINIMIZE_TO_TRAY": true,
                     "arRPC": true,
                     "discordBranch": "stable",
                     "splashBackground": "rgb(30, 30, 46)",
                     "splashColor":"rgb(186, 194, 222)",
                     "splashTheming": true,
                     "staticTitle": false,
                     "splashAnimationPath": "${../../dots/nso-needy-streamer.gif}",
                     "clickTrayToShowHide": true
                 }
            '';
          };
          systemd.services = {
            arRPC = {
              description = "Discord Rich Prescence";
              after = [ "graphical-session.target" ];
              partOf = [ "graphical-session.target" ];
              serviceConfig = {
                ExecStart = "${pkgs.arrpc}/bin/arrpc";
                Restart = "on-failure";
              };
            };
          };
        };
      };
}
