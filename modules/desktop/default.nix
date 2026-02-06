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
    ./kurukurudm.nix
    ./niri.nix
    # ./sddm.nix
    ./qt.nix
    ./xserver.nix
  ];

  options.kagurazakei.desktop.enable = lib.mkEnableOption "desktop enviroment";

  config = lib.mkIf config.kagurazakei.desktop.enable {

    # Session variables for wayland usage
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };

    # Hjem for file management
    hjem.users = lib.genAttrs users (user: {
      files = {
        ".config/mpv".source = ../../dots/mpv;
        ".config/fuzzel/fuzzel.ini".source = ../../dots/fuzzel/fuzzel.ini;
        ".config/fuzzel/themes".source = sources.catfuzzel + "/themes";
      };
    });

  };
}
