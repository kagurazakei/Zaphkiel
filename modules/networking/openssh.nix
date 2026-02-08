{
  lib,
  config,
  ...
}:
{
  options.kagurazakei.networking.openssh.enable = lib.mkEnableOption "openssh";

  config =
    lib.mkIf (config.kagurazakei.networking.openssh.enable && config.kagurazakei.networking.enable)
      {

        # Enable the OpenSSH daemon.
        services.openssh = {
          enable = true;
          startWhenNeeded = true;
          openFirewall = false;
          knownHosts = {
            "hana".publicKey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjywfRHVDeBQBFYZym/c3JDVRwni//tSy5FPKmTgLyN antonio@hana";
            "laptop".publicKey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZ/2mQLJkKdNyfUvXI4KTneGLe6i7WXk+7Kl6ceeA7j maotsugiri@gmail.com";
          };
        };

        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };
}
