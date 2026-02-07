{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{

  options.kagurazakei.programs.nvim.enable = mkEnableOption "nvim";
  config = mkIf (config.kagurazakei.programs.nvim.enable && config.kagurazakei.programs.enable) {
    environment.systemPackages = [
      inputs.zakeivim.packages.${pkgs.stdenv.hostPlatform.system}.khanelivim
      pkgs.lazygit
      pkgs.krabby
    ];
    hjem.users.antonio = {
      xdg.config.files = {
        "lazygit/config.yml".source = ../../dots/lazygit/config.yml;
      };
    };
  };
}
