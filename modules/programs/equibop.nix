{
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${user}" ])

  ];
  environment.systemPackages = [
    pkgs.equibop
  ];
  hj = {
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
               "splashAnimationPath": "${./themes/nso-needy-streamer.gif}",
               "clickTrayToShowHide": true
           }
      '';
    };
  };

}
