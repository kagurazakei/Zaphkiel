{
  config,
  lib,
  ...
}:
{

  options.kagurazakei.hardware.power.enable = lib.mkEnableOption "Power and Battery Options";

  config = lib.mkIf (config.kagurazakei.hardware.power.enable && config.kagurazakei.hardware.enable) {

    # Enable power profiles
    services.power-profiles-daemon.enable = true;

    # Enable upower daemon
    services.upower = {
      enable = true;
    };
  };
}
