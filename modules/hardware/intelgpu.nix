{
  pkgs,
  lib,
  config,
  ...
}:
{

  options.kagurazakei.hardware.intelgpu.enable = lib.mkEnableOption "intel graphics";

  config =
    lib.mkIf (config.kagurazakei.hardware.intelgpu.enable && config.kagurazakei.hardware.enable)
      {

        # Failsafe if FFMPEG/QSV fails to initialize
        boot.kernelParams = [ "i915.enable_guc=3" ];

        # Intel graphics packages
        hardware = {
          enableRedistributableFirmware = true;
          graphics = {
            enable = true;
            extraPackages = with pkgs; [
              intel-ocl
              intel-media-driver
            ];
          };
        };

        # Suggest intel HD graphics to programs that use iGPU
        environment.sessionVariables = {
          LIBVA_DRIVER_NAME = "iHD";
        };
      };
}
