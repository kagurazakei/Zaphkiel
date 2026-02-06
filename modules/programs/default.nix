{
  lib,
  config,
  pkgs,
  ...
}:
{

  imports = [
    # ./aagl.nix
    ./browser.nix
    ./equibop.nix
    ./foot.nix
    ./nixpkgs.nix
    ./nvim.nix
    ./steam.nix
    ./dolphin.nix
    # ./vm.nix
  ];

  options.kagurazakei.programs.enable = lib.mkEnableOption "programs";

  config = lib.mkIf config.kagurazakei.programs.enable {
    environment.systemPackages = [
      pkgs.swappy
      pkgs.gh
    ];
    # Disable nano
    programs.nano.enable = false;

    # Enable git
    programs.git.enable = true;

    # Set default editor
    environment.variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # Set default applications
    xdg = {
      terminal-exec = {
        enable = true;
        settings = {
          default = [
            "foot.desktop"
          ];
        };
      };
      mime.defaultApplications = {
        "image" = "swappy.desktop";
      };
    };
  };
}
