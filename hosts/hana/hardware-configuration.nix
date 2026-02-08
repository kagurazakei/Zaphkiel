# Beryl Hardware Configuration
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.huawei-machc-wa
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c8526095-a48a-45f2-85a9-5cd416f97713";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c8526095-a48a-45f2-85a9-5cd416f97713";
    fsType = "btrfs";
    options = [ "subvol=home" ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c8526095-a48a-45f2-85a9-5cd416f97713";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/c8526095-a48a-45f2-85a9-5cd416f97713";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4135-A759";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/71ec5055-6185-4447-8e9d-cbd9a8f95b91"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # Enable Fingerprint Sensor, Elan 04f3:0c6e type fingerprint
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-elan;
  };

  # Enable Asus Numpad Service (wayland-1 for niri)
  # Potential fix for AMD Rembrandt Hardware Acceleration Crash? I'll find out soon
  boot.kernelParams = [
    "idle=nowwait"
    "iommu=pt"
  ];

}
