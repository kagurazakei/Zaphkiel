{ self, ... }:
{
  dandelion.profiles.niri = {
    imports = [
      self.dandelion.modules.niri
      self.dandelion.modules.noctalia
      self.dandelion.modules.compositor-common
      self.dandelion.modules.qt
    ];
  };
}
