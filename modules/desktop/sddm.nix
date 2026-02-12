{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.silentSDDM.nixosModules.default
  ];
  options.kagurazakei.desktop.sddm.enable = lib.mkEnableOption "Simple display manager";

  config = lib.mkIf (config.kagurazakei.desktop.sddm.enable && config.kagurazakei.desktop.enable) {
    environment.systemPackages = [
      inputs.waifu-cursors.packages.${pkgs.stdenv.hostPlatform.system}.Reichi-Shinigami
      inputs.shizuruPkgs.packages.${pkgs.stdenv.hostPlatform.system}.kureiji-ollie-cursors
    ];
    hj = {
      packages = [
        inputs.waifu-cursors.packages.${pkgs.stdenv.hostPlatform.system}.Reichi-Shinigami
        inputs.shizuruPkgs.packages.${pkgs.stdenv.hostPlatform.system}.kureiji-ollie-cursors
      ];
    };
    services.displayManager.sddm = {
      settings = {
        Theme = {
          CursorTheme = "Kureiji-Ollie-v2";
        };
      };
    };
    programs = {
      silentSDDM = {
        enable = true;
        theme = "rei";
      };
    };
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor manager by UWSM";
          binPath = "/run/current-system/sw/bin/start-hyprland";
        };
        niri = {
          prettyName = "Niri The Goat";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };
  };
}
