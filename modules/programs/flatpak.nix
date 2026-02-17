{nix-flatpak, ...}: {
  dandelion.modules.flatpak = {...}: {
    imports = [
      nix-flatpak.nixosModules.nix-flatpak
    ];
    services = {
      flatpak = {
        enable = true;
        packages = [
          "com.github.tchx84.Flatseal"
          "app.opencomic.OpenComic"
        ];
      };
    };
  };
}
