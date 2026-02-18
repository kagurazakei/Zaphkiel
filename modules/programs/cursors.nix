{waifu-cursors, ...}: {
  azalea.modules.cursors = {pkgs, ...}: {
    environment.systemPackages = [
      waifu-cursors.packages.${pkgs.stdenv.hostPlatform.system}.all
    ];
  };
}
