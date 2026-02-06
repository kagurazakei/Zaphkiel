{
  pkgs,
  lib,
  config,
  ...
}:
{

  options.kagurazakei.system.fonts.enable = lib.mkEnableOption "fonts";

  config = lib.mkIf (config.kagurazakei.system.fonts.enable && config.kagurazakei.system.enable) {

    # Fonts
    fonts = {
      packages = with pkgs; [
        carlito
        dejavu_fonts
        ipafont
        kochi-substitute
        source-code-pro
        ttf_bitstream_vera
        nerd-fonts.caskaydia-mono
        nerd-fonts.caskaydia-cove
        nerd-fonts.jetbrains-mono
        material-symbols
      ];
      fontconfig = {
        defaultFonts = {
          serif = [
            "JetBrainsMono Nerd Font"
          ];
          sansSerif = [
            "JetBrainsMono Nerd Font"
          ];
          monospace = [
            "JetBrainsMono Nerd Font"
          ];
        };
      };
    };
  };
}
