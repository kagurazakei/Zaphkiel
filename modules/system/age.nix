{
  inputs,
  users,
  pkgs,
  ...
}:
{
  imports = [ inputs.agenix.nixosModules.default ];
  environment.systemPackages = [
    (inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default)
  ];
  age.identityPaths = [
    "/persistent/etc/sops-nix/id_ed25519"
    "/persistent/etc/sops-nix/keys.txt"
  ]
  ++ builtins.map (username: "/home/${username}/.ssh/id_ed25519") users;
}
