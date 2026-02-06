{
  pkgs,
  lib,
  config,
  ...
}:
{

  options.kagurazakei.hardware.nvidia.enable = lib.mkEnableOption "nvidia graphics";

  config =
    lib.mkIf (config.kagurazakei.hardware.nvidia.enable && config.kagurazakei.hardware.enable)
      {

        boot = {
          kernelModules = [
            "nvidia"
            "nvidia_modeset"
            "nvidia_uvm"
            "nvidia_drm"
          ];

          kernelParams = [
            "nvidia-drm.modeset=1"
            "nvidia-drm.fbdev=1"
          ];
        };

        hardware.graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            libva-vdpau-driver
            libvdpau
            libvdpau-va-gl
            nvidia-vaapi-driver
            vdpauinfo
            libva
            libva-utils
          ];
        };

        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          nvidiaPersistenced = true;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };
}
