{chaotic, ...}: {
  dandelion.modules.scheduler = {pkgs, ...}: {
    imports = [chaotic.nixosModules.default];
    chaotic.nyx.overlay.enable = true;
    services.scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };
}
