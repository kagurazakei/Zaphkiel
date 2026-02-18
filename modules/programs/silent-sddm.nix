{ silentSDDM, ... }:
{
  azalea.modules.silent-sddm =
    {
      pkgs,
      ...
    }:
    let
      sddm-silent = silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        wayland.enable = true;
        extraPackages = [
          silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default
          pkgs.bibata-cursors
          pkgs.kdePackages.qtbase
        ];
        theme = "silent";
        settings = {
          General = {
            GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-silent}/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard";
            InputMethod = "qtvirtualkeyboard";
          };
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
          };
        };
      };
    };
}
