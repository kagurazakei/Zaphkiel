# Beryl Configuration
{
  lib,
  ...
}:
{
  imports = [
    # Imports.
    ../../modules
  ];

  # All modules and their values
  kagurazakei = {
    enable = true;

    desktop = {
      enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
      niri.enable = true;
      # kurukurudm.enable = true;
      sddm.enable = true;
      xserver.enable = true;
      # greetd.enable = true;
    };

    hardware = {
      enable = true;
      amdgpu.enable = false;
      nvidia.enable = true;
      intelgpu.enable = true;
      audio.enable = true;
      power.enable = true;
    };

    networking = {
      enable = true;
      bluetooth.enable = true;
      # dnscrypt.enable = false;
      openssh.enable = true;
      # taildrive.enable = true;
      # tailscale.enable = true;
    };

    programs = {
      enable = true;
      browser.enable = true;
      foot.enable = true;
      fuzzel.enable = true;
      yazi.enable = true;
      equibop.enable = true;
      dolphin.enable = true;
      core.enable = true;
      desktop.enable = true;
      nvim.enable = true;
      steam.enable = false;
      vscodium.enable = true;
      flatpak.enable = true;
    };

    system = {
      enable = true;
      bootloader.enable = true;
      fish.enable = true;
      fonts.enable = true;
      input.enable = true;
      antonio.enable = true;
    };
  };

  networking.hostName = "hana"; # The tint of blue I like
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Yangon";

  # Prioritize Fingerprint
  # programs.kurukuruDM.settings.instantAuth = lib.mkForce true;

  /*
    This value determines the NixOS release from which the default
    settings for stateful data, like file locations and database versions
    on your system were taken. It‘s perfectly fine and recommended to leave
    this value at the release version of the first install of this system.
    Before changing this value read the documentation for this option
    (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  */
  system.stateVersion = "26.05"; # Did you read the comment?
}
