# Importer and Defaults maker
{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./age.nix
    ./bootloader.nix
    ./fish.nix
    ./fonts.nix
    ./kernel.nix
    ./input.nix
    ./impermanence.nix
    ./locale.nix
    ./nix.nix
    ./users.nix
    ./security.nix
    ./zram.nix
  ];

  options.kagurazakei.system.enable = lib.mkEnableOption "system";

  config = lib.mkIf config.kagurazakei.system.enable {

    # Enable core firmware services
    services = {
      printing.enable = lib.mkDefault true;
      gvfs.enable = lib.mkDefault true;
      udisks2.enable = lib.mkDefault true;
      fwupd.enable = lib.mkDefault true;
      tumbler.enable = true;
      dbus = {
        enable = true;
        packages = with pkgs; [
          gcr
          gnome-settings-daemon
        ];
      };
    };
  };
}
