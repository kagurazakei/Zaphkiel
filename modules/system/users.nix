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

in
{
  imports = [ inputs.hjem.nixosModules.default ];

  # Options maker
  options.kagurazakei.system = {
    antonio.enable = mkEnableOption "Enable the antonio user";
  };

  config = mkMerge [
    # WHERE DOES THE STOMEE LIVE???
    (mkIf (config.kagurazakei.system.antonio.enable && config.kagurazakei.system.enable) {

      age.secrets.secret1 = {
        file = ../../secrets/secret1.age;
        owner = "antonio";
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
          ];

          hashedPasswordFile = config.age.secrets.secret1.path;
        };
      };

      # Set face icon for sumee
      systemd.tmpfiles.rules = lib.pipe users [
        (builtins.filter (user: config.hjem.users.${user}.files.".face.icon".source != null))
        (builtins.map (user: [
          "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
          "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${
            config.hjem.users.${user}.files.".face.icon".source
          }"
        ]))
        (lib.flatten)
      ];

      # hjem config for sumee
      hjem.users = lib.genAttrs users (user: {
        enable = true;
        directory = config.users.users.${user}.home;
        clobberFiles = lib.mkForce true;
        files =
          let
            profile = pkgs.fetchurl {
              name = "profile.png";
              url = "https://github.com/kagurazakei/shizuru/blob/main/configs/profile.png";
              hash = "sha256-Uqw5jy26bEFx/qN4JjPr6KF74oIsV+cfwFZQ4q+VqSg=";
            };
            # Make face.icon at /home/user/
            faceIcon =
              let
                pfp = pkgs.fetchurl {
                  name = "vivianpfp.jpg";
                  url = "https://cdn.donmai.us/original/b3/b2/__vivian_banshee_zenless_zone_zero_drawn_by_icetea_art__b3b237c829304f29705f1291118e468f.jpg?download=1";
                  hash = "sha256-KQZHp4tOufAOI4utGo8zLpihicMTzF5dRzQPEKc4omI=";
                };
              in
              pkgs.runCommandWith
                {
                  name = "cropped-${pfp.name}";
                  derivationArgs.nativeBuildInputs = [ pkgs.imagemagick ];
                }
                ''
                  magick ${pfp} -crop 1000x1000+210+100 - > $out
                '';

          in
          {
            ".face.icon".source = profile;
            ".config/btop/btop.conf".source = ../../dots/btop/btop.conf;
            ".config/btop/themes".source = sources.rosebtop;
          };
      });
    })

    # SHE'S MAKING A SUPERCOMPUTER IN MINECRAFT AGAIN????
    (mkIf (config.kagurazakei.system.nahida.enable && config.kagurazakei.system.enable) {

      users.users = {
        hana = {
          isNormalUser = true;
          description = "For Hana";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
      };
    })
  ];
}
