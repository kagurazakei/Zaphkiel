{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.chaotic.nixosModules.default ];
  options.kagurazakei.hardware.nvidia.enable = lib.mkEnableOption "nvidia graphics";

  config =
    lib.mkIf (config.kagurazakei.hardware.nvidia.enable && config.kagurazakei.hardware.enable)
      {
        chaotic.nyx.overlay.enable = true;
        environment.systemPackages = with pkgs; [
          vulkanPackages_latest.vulkan-loader
          vulkanPackages_latest.vulkan-tools
          libva-utils
          tmux
          bottom
          htop
        ];
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
            mesa
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
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
          };
        };
      };
}
