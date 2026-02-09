{
  config,
  inputs,
  sources,
  lib,
  pkgs,
  users,
  ...
}:
let

  inherit (lib) mkEnableOption mkMerge mkIf;
  dots = "${../../dots}";
in
{
  imports = [
    ./hjem-modules.nix
  ];

  # Options maker
  options.kagurazakei.system = {
    antonio.enable = mkEnableOption "Enable the antonio user";
  };

  config = mkMerge [
    # WHERE DOES THE STOMEE LIVE???
    (mkIf (config.kagurazakei.system.antonio.enable && config.kagurazakei.system.enable) {

      age.secrets = {
        secret4 = {
          file = ../../secrets/secret4.age;
          owner = "antonio";
        };

        secret5 = {
          file = ../../secrets/secret5.age;
          owner = "antonio";
          mode = "0500";
          path = "/etc/nix/nix-access-token.conf";
        };
        secret6 = {
          file = ../../secrets/secret6.age;
          owner = "antonio";
          path = "/home/antonio/.config/keys/github.txt";
        };
        secret8 = {
          file = ../../secrets/secret8.age;
          owner = "antonio";
        };
        secret9 = {
          file = ../../secrets/secret9.age;
          owner = "antonio";
        };
      };
      users.users = {
        antonio = {
          isNormalUser = true;
          description = "Hi There";
          extraGroups = [
            "networkmanager"
            "wheel"
            "fuse"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjywfRHVDeBQBFYZym/c3JDVRwni//tSy5FPKmTgLyN antonio@hana"
          ];

          hashedPasswordFile = config.age.secrets.secret4.path;
        };
      };

    })

  ];
}
