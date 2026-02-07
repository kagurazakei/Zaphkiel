self: super:

{
  qt6Packages = super.qt6Packages.overrideScope' (
    _: _: {
      qt6ct = (import ./default.nix { pkgs = super; }).qt6ct;
    }
  );
}
