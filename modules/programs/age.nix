{ agenix, ... }:
{
  dandelion.modules.agenix =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        agenix.nixosModules.default
        (lib.mkAliasOptionModule [ "zaphkiel" "secrets" ] [ "age" "secrets" ])
      ];
      environment.systemPackages = [ (agenix.packages.${pkgs.stdenv.hostPlatform.system}.default) ];
      age.identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/persistent/etc/sops-nix/id_ed25519"
      ]
      ++ builtins.map (username: "/home/${username}/.ssh/id_ed25519") config.zaphkiel.data.users;
    };
}
