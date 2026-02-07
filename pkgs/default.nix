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
    cursors = callPackage ./cursors.nix { };
    qt6ct = callPackage ./qt6ct { };
    mpv-wrapped = callPackage ./mpv-wrapped/package.nix { };
    catMocha-icons = callPackage ./papirus-catppuccin.nix { };
  }
)
