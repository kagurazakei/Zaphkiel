{
  pkgs,
  lib,
  ...
}:
lib.fix (
  self:
  let
    inherit (pkgs) callPackage;
  in
  {
    favIcon = callPackage ./favCatIcon.nix { };
    iconsTheme = pkgs.catppuccin-papirus-folders.override {
      accent = "pink";
      flavor = "mocha";
    };
    mpv-wrapped = callPackage ./mpv-wrapped.nix { };
    cursors = callPackage ./cursors.nix { };
    qt6ct = callPackage ./qt6ct { };
    catMocha-icons = callPackage ./papirus-catppuccin.nix { };
    viu-custom = callPackage ./viu.nix { };
  }
)
