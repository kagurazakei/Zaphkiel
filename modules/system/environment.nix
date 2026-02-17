{
  self,
  zakeivim,
  ...
}: {
  dandelion.modules.environment = {pkgs, ...}: {
    environment.systemPackages = [
      # self.packages.${pkgs.stdenv.hostPlatform.system}.xvim.default
      pkgs.git
      pkgs.npins
      pkgs.neovim
      pkgs.alejandra
      zakeivim.packages.${pkgs.stdenv.hostPlatform.system}.khanelivim
    ];

    environment.variables.EDITOR = "nvim";
    environment.variables.MANPAGER = "nvim +Man!";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # nano deez nutz
    programs.nano.enable = false;
  };
}
