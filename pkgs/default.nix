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
    # favCursor = callPackage ./cursors.nix { };
    favIcon = callPackage ./favCatIcon.nix { };
    iconsTheme = pkgs.catppuccin-papirus-folders.override {
      accent = "pink";
      flavor = "mocha";
    };
    qt6ct = callPackage ./qt6ct { };
    mpv-wrapped = callPackage ./mpv-wrapped/package.nix { };
  }
)
