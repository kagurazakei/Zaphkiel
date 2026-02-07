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
        xserver.videoDriver = [
          "modesetting"
          "nvidia"
        ];
        chaotic.nyx.overlay.enable = true;
        environment.systemPackages = with pkgs; [
          vulkanPackages_latest.vulkan-loader
          vulkanPackages_latest.vulkan-tools
          libva-utils
          tmux
          bottom
          htop
          egl-wayland
          mesa
        ];
        # Failsafe if FFMPEG/QSV fails to initialize
        boot.kernelParams = [ "i915.enable_guc=3" ];

        # chaotic.mesa-git = {
        #   enable = true;
        #   extraPackages = with pkgs; [
        #     intel-media-driver
        #   ];
        # };
        # Intel graphics packages
        hardware = {
          enableRedistributableFirmware = true;
          graphics = {
            enable = true;
            extraPackages = with pkgs; [
              intel-ocl
              intel-media-driver
              libva-vdpau-driver
              libvdpau
              libvdpau-va-gl
              nvidia-vaapi-driver
              vdpauinfo
              libva
              libva-utils
            ];
          };
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
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
        };

        # Suggest intel HD graphics to programs that use iGPU
        environment.sessionVariables = {
          LIBVA_DRIVER_NAME = "iHD";
        };
      };

}
