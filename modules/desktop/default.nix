{
  config,
  lib,
  users,
  sources,
  ...
}:
{
  imports = [
    # Import files
    ./greetd.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    # ./kurukurudm.nix
    ./niri.nix
    ./sddm.nix
    ./xserver.nix
  ];

  options.kagurazakei.desktop.enable = lib.mkEnableOption "desktop enviroment";

  config = lib.mkIf config.kagurazakei.desktop.enable {

    # Session variables for wayland usage
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };
  };
}
