{
  config,
  lib,
  users,
  ...
}:
{
  options.kagurazakei.networking.taildrive.enable = lib.mkEnableOption "taildrive";

  config =
    lib.mkIf (config.kagurazakei.networking.taildrive.enable && config.kagurazakei.networking.enable)
      {

        # Set taildrive to mount in sumee folder
        fileSystems."/run/media/sumee/taildrive" = {
          device = "sumee@kagurazakei:/run/media/sumee/emerald";
          fsType = "sshfs";
          options = [
            "allow_other"
            "umask=003"
            "_netdev"
            "x-systemd.automount"
            "compression=yes"
            "cache=yes"
            "auto_cache"
            "reconnect"
            "ServerAliveInterval=15"
            "ServerAliveCountMax=3"
            "IdentityFile=${
              builtins.concatStringsSep "," (
                builtins.map (user: "${config.users.users.${user}.home}/.ssh/id_ed25519") users
              )
            }"
          ];
        };
      };
}
