{
  config,
  lib,
  ...
}:
{

  options.kagurazakei.networking.bluetooth.enable = lib.mkEnableOption "bluetooth service";

  config =
    lib.mkIf (config.kagurazakei.networking.bluetooth.enable && config.kagurazakei.networking.enable)
      {

        # Enable bluetooth
        hardware.bluetooth.enable = true;

        # Enable blueman, bluetooth manager
        services.blueman.enable = true;

      };
}
