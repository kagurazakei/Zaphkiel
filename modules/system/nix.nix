# NIX DOT NIX I ALWAYS WANTED TO NAME IT
{
  inputs,
  pkgs,
  config,
  ...
}:
{

  # Essential config changes
  nixpkgs = {
    config.allowUnfree = true;
  };

  # Enable core nix features
  nix = {
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    settings = {
      allow-import-from-derivation = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];

      extra-substituters = [
        "https://sumee.cachix.org"
        "https://nix-community.cachix.org"
        "https://catppuccin.cachix.org"
        "https://niri.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      extra-trusted-public-keys = [
        "sumee.cachix.org-1:Hq6j5JXABEiSpFsSMwAJLiAclMmBpdP+gsUgVy2Ld4Y="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };
    gc = {
      persistent = true;
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      !include ${config.age.secrets.secret2.path}
    '';
  };
}
