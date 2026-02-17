{self, ...}: {
  dandelion.profiles.default = {
    imports = [
      self.dandelion.modules.agenix
      self.dandelion.modules.hjem
      self.dandelion.modules.hjem-impure
      self.dandelion.modules.hjem-matugen
      self.dandelion.modules.zaphkiel-data
      self.dandelion.modules.locales
      self.dandelion.modules.impermanence
      self.dandelion.modules.boot
      self.dandelion.modules.kernel
      self.dandelion.modules.security
      self.dandelion.modules.flatpak
      self.dandelion.modules.scheduler
      self.dandelion.modules.input
      # programs
      self.dandelion.modules.environment
      self.dandelion.modules.nix
      self.dandelion.modules.fish
      self.dandelion.modules.direnv
      # self.dandelion.modules.shpool
      # network
      # self.dandelion.modules.dnscrypt
      # self.dandelion.modules.tailscale
      # self.dandelion.modules.openssh
      # hardware
      self.dandelion.modules.undetected
    ];
  };
}
