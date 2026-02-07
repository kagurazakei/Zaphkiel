{
  lib,
  config,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    ./amdgpu.nix
    ./audio.nix
    ./intelgpu.nix
    ./nvidia.nix
    ./power.nix

    # Scans undetected hardware
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Import hardware modules
  options.kagurazakei.hardware.enable = lib.mkEnableOption "hardware";

  config = lib.mkIf config.kagurazakei.hardware.enable {

    # Define host platform
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    environment.systemPackages = [
      pkgs.egl-wayland
    ];
  };
}
