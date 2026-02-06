{
  pkgs,
  lib,
  ...
}:
let
  username = "antonio";
  qt6ctOverlay = final: prev: {
    qt6Packages = prev.qt6Packages.overrideScope (
      qfinal: qprev: {
        qt6ct = qprev.qt6ct.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "ilya-fedin";
            repo = "qt6ct";
            rev = "26b539af69cf997c6878d41ba75ad7060b20e56e";
            hash = "sha256-ePY+BEpEcAq11+pUMjQ4XG358x3bXFQWwI1UAi+KmLo=";
          };

          nativeBuildInputs = (lib.lists.remove qfinal.qmake old.nativeBuildInputs) ++ [ final.cmake ];

          buildInputs = old.buildInputs ++ [
            final.kdePackages.kconfig
            final.kdePackages.kcolorscheme
            final.kdePackages.kiconthemes
            final.libsForQt5.qtstyleplugins
          ];

          cmakeFlags = [
            (lib.cmakeFeature "PLUGINDIR" "lib/qt-6/plugins")
          ];
        });
      }
    );
  };
in
{
  imports = [
    (lib.modules.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${username}" ])
  ];
  nixpkgs.overlays = [
    qt6ctOverlay
  ];
  qt.enable = true;
  environment.systemPackages = with pkgs; [
    qt6.qtdeclarative
    qt6.qtmultimedia
    wlsunset
    libqalculate
    quickshell
  ];
  hj.packages = with pkgs; [

    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "pink" ];
    })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qqc2-desktop-style
    master.kdePackages.qt6ct
    adwaita-qt6
    qt6.qtwayland
    qt6.qtsvg
    qt6Packages.qtstyleplugin-kvantum
    kdePackages.kdialog
    kdePackages.qtpositioning
    kdePackages.syntax-highlighting
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    kdePackages.qt5compat
    kdePackages.sonnet
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.breeze
    quickshell
  ];
}
