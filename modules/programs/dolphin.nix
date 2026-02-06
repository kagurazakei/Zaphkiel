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
  hj = {
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
}
