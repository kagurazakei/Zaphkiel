{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.kagurazakei.desktop.xserver.enable = lib.mkEnableOption "X11 windowing";

  config = lib.mkIf (config.kagurazakei.desktop.xserver.enable && config.kagurazakei.desktop.enable) {

    # Enable the X11 windowing system
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [ xterm ];
      displayManager = {
        setupCommands = "";
      };
    };
  };
}
