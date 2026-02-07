{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  username = "antonio";
in
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  imports = [
    inputs.nur-repo-override.nixosModules.qt6ct
  ];
  qt.enable = true;
  environment.systemPackages = with pkgs; [
    wlsunset
    libqalculate
    quickshell
    papirus-icon-theme
    catppuccin-papirus-folders
  ];
  hjem.users.${username}.packages = with pkgs; [
    nur.repos.ilya-fedin.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.qqc2-desktop-style
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
  environment.variables = {
    QT_PLUGIN_PATH = [
      "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtPluginPrefix}"
    ];
    QML2_IMPORT_PATH = [
      "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtQmlPrefix}"
    ];
  };
}
