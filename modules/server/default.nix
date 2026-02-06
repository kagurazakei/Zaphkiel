{
  lib,
  config,
  ...
}:
{

  imports = [
    # ./anki.nix
    # ./auth.nix
    # ./davis.nix
    # ./files.nix
    # ./immich.nix
    # ./jellyfin.nix
    # ./memos.nix
    # ./ollama.nix
    # ./suwayomi.nix
  ];

  options.kagurazakei.server.enable = lib.mkEnableOption "enable server modules";

  config = lib.mkIf config.kagurazakei.server.enable {

    # Enable GNU Screen
    programs.screen.enable = true;
  };
}
