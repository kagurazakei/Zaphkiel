{
  inputs,
  lib,
  config,
  ...
}:
{

  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  options.kagurazakei.programs.flatpak.enable = lib.mkEnableOption "flatpak";

  config =
    lib.mkIf (config.kagurazakei.programs.flatpak.enable && config.kagurazakei.programs.enable)
      {
        services = {
          flatpak = {
            enable = true;
            packages = [
              "com.github.tchx84.Flatseal"
              "app.opencomic.OpenComic"
            ];
          };
        };
      };
}
