{
  config,
  lib,
  users,
  sources,
  ...
}:
{
  options.kagurazakei.programs.foot.enable = lib.mkEnableOption "foot";

  config = lib.mkIf (config.kagurazakei.programs.foot.enable && config.kagurazakei.programs.enable) {

    # Foot terminal
    programs.foot = {
      enable = true;
    };

    # Foot Theming
    hjem.users = lib.genAttrs users (user: {
      files = {
        ".config/foot/foot.ini".source = ../../dots/foot/foot.ini;
        ".config/foot/rose-pine.ini".source = sources.rosefoot + "/rose-pine";
      };
    });
  };
}
