{
  inputs,
  lib,
  config,
  sources,
  pkgs,
  ...
}:
let
  username = "antonio";
  dots = "${../../dots}";
in
{

  imports = [
    inputs.hjem.nixosModules.default
    (lib.mkAliasOptionModule [ "hj" ] [ "hjem" "users" "${username}" ])
  ];
  hjem = {
    extraModules = [
      inputs.hjem-impure.hjemModules.default
      inputs.hjem-rum.hjemModules.default
    ];
    users.${username} = {
      impure = {
        enable = true;
        dotsDir = dots;
        dotsDirImpure = "/home/antonio/nixos/dots";
      };
      enable = true;
      directory = config.users.users.${username}.home;
      clobberFiles = lib.mkForce true;
      xdg.config.files =
        let
          profile = pkgs.fetchurl {
            name = "profile.png";
            url = "https://github.com/kagurazakei/shizuru/blob/main/configs/profile.png";
            hash = "sha256-QXKhMCjVpXTZnGd3pfFKb8w7xx6lSLPYwC/32fcggJU=";
          };

          tanjiro = pkgs.fetchurl {
            name = "tanjiro";
            url = "https://github.com/kagurazakei/wallpapers/blob/main/1215947.jpg";
            hash = "sha256-9BypF+oea8eAzxleqBZI94JAjdcjWX+WLrPcOYYQnOM=";
          };
          dot = config.hjem.users.${username}.impure.dotsDir;
        in
        {

          ".face.icon".source = profile;
          "btop/btop.conf".source = ../../dots/btop/btop.conf;
          "btop/themes".source = sources.rosebtop;
          "fish/config.fish".source = lib.mkForce (dot + "/fish/config.fish");
          "fish/user_variables.fish".source = lib.mkForce (dot + "/fish/user_variables.fish");
          "fish/abbreviations.fish".source = lib.mkForce (dot + "/fish/abbreviations.fish");
          "fish/aliases.fish".source = lib.mkForce (dot + "/fish/aliases.fish");
          "fuzzel/fuzzel.ini".source = lib.mkForce (dot + "/fuzzel/fuzzel.ini");
          "fuzzel/noctalia".source = lib.mkForce (dot + "/fuzzel/noctalia");
          "kitty/kitty.conf".source = lib.mkForce (dot + "/kitty/kitty.conf");
          "kitty/themes/oxocarbon.conf".source = lib.mkForce (dot + "/kitty/themes/oxocarbon.conf");
          "niri/config.kdl".source = lib.mkForce (dot + "/niri/config.kdl");
          "menus/applications.menu".source = lib.mkForce (dot + "/menus/applications.menu");
          "dolphinrc".source = lib.mkForce (dot + "/dolphinrc");
          "carapace/carapace.toml".source = lib.mkForce (dot + "/carapace/carapace.toml");
          # nushell config
          "nushell/config.nu".source = lib.mkForce (dot + "/nushell/config.nu");
          "nushell/env.nu".source = lib.mkForce (dot + "/nushell/env.nu");
          "nushell/git-status.nu".source = lib.mkForce (dot + "/nushell/git-status.nu");
          "noctalia/colors.json".source = lib.mkForce (dot + "/noctalia/colors.json");
          "noctalia/settings.json".source = lib.mkForce (dot + "/noctalia/settings.json");
          "wallpapers/schizomiku.jpg".source = tanjiro;

          ### Wezterm Config
          "wezterm/wezterm.lua".source = lib.mkForce (dot + "/wezterm/wezterm.lua");
          "wezterm/colors/oxocarbon-dark.toml".source = lib.mkForce (
            dot + "/wezterm/colors/oxocarbon-dark.toml"
          );
          "yazi/init.lua".source = lib.mkForce (dot + "/yazi/init.lua");
          "yazi/yazi.toml".source = lib.mkForce (dot + "/yazi/yazi.toml");
          "yazi/keymap.toml".source = lib.mkForce (dot + "/yazi/keymap.toml");
          "yazi/package.toml".source = lib.mkForce (dot + "/yazi/package.toml");
          "yazi/theme.toml".source = lib.mkForce (dot + "/yazi/theme.toml");
          "yazi/flavors/oxocarbon.yazi/flavor.toml".source = lib.mkForce (
            dot + "/yazi/flavors/oxocarbon.yazi/flavor.toml"
          );
          "yazi/flavors/catppuccin-macchiato.yazi/flavor.toml".source = lib.mkForce (
            dot + "/yazi/flavors/catppuccin-macchiato.yazi/flavor.toml"
          );
          ### zellij
          "zellij/config.kdl".source = lib.mkForce (dot + "/zellij/config.kdl");
          "zellij/layouts/default.kdl".source = lib.mkForce (dot + "/zellij/layouts/default.kdl");
          "zellij/layouts/nodejs.kdl".source = lib.mkForce (dot + "/zellij/layouts/nodejs.kdl");
          "zellij/themes/catppuccin.kdl".source = lib.mkForce (dot + "/zellij/themes/catppuccin.kdl");
        };
    };
  };
}
