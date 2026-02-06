{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.kagurazakei.programs.vm.enable = lib.mkEnableOption "libvirtd for VM";

  config = lib.mkIf (config.kagurazakei.programs.vm.enable && config.kagurazakei.programs.enable) {

    # Add users to libvirtd group
    users.users.antonio.extraGroups = [ "libvirtd" ];

    # Enable virt-man
    programs.virt-manager.enable = true;

    # Virtualisation Config
    virtualisation = {
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };
    };

    # Provide UEFI firmware support to virt-manager (due to depreciated OVMF module)
    systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    # This might fucking work
    networking = {
      firewall.trustedInterfaces = [ "virbr0" ];
    };

    environment.systemPackages = with pkgs; [
      dnsmasq
    ];
  };
}
