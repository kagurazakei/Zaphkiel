{
  config,
  pkgs,
  lib,
  users,
  user,
  inputs,
  ...
}:
{

  imports = [
    ./qt.nix
  ];
  options.kagurazakei.desktop.niri.enable = lib.mkEnableOption "niri";

  config = lib.mkIf (config.kagurazakei.desktop.niri.enable && config.kagurazakei.desktop.enable) {
    # Enable Niri
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    # Set niri as default session
    services.displayManager.defaultSession = "niri";

    # Xwayland satellite for X11 Windowing Support
    systemd.user.services.xwayland-satellite.wantedBy = [ "graphical-session.target" ];
    # Niri Dependencies
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      jq
      kitty
      lsd
      nitch
      fastfetch
      yazi
    ];

    # Niri Hjem config
    hjem.users = lib.genAttrs users (user: {
      packages = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        kdePackages.polkit-kde-agent-1
        polkit_gnome
        xdg-desktop-portal-wlr
      ];
      files =
        let

          # Set keybind toggle scripts
          keybinds =
            let
              camerascript = pkgs.writeShellScriptBin "camScript" ''
                if ${pkgs.kmod}/bin/lsmod | grep -q uvcvideo; then
                  ${pkgs.polkit}/bin/pkexec ${pkgs.kmod}/bin/modprobe -rf uvcvideo;
                  ${pkgs.brightnessctl}/bin/brightnessctl -d asus::camera set 1
                else
                  ${pkgs.polkit}/bin/pkexec ${pkgs.kmod}/bin/modprobe uvcvideo;
                  ${pkgs.brightnessctl}/bin/brightnessctl -d asus::camera set 0
                fi
              '';

              mutescript = pkgs.writeShellScriptBin "muteScript" ''
                ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle;
                ${pkgs.brightnessctl}/bin/brightnessctl -d platform::micmute set $(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED)
              '';

              from = [
                "I_HATE_DMV_LINES"
                "NICHIFALEMA?"
              ];
              to = [
                "${mutescript}/bin/muteScript"
                "${camerascript}/bin/camScript"
              ];
            in
            builtins.replaceStrings from to (builtins.readFile ../../dots/niri/waste.kdl);

          # Set hypridle command
          quickidle =
            let
              from = [
                "%%刺し身％％"
                "%%WOEMYASS**"
                "%%HAEINCI&&"
              ];
              # qs keeps crashing during Wlr session lock, so hyprlock for now
              to = [
                # "noctalia-shell ipc call lockScreen lock"
                "pidof hyprlock || hyprlock"
                "niri msg action power-on-monitors"
                "niri msg action power-off-monitors"
              ];
            in
            builtins.replaceStrings from to (builtins.readFile ../../dots/hyprland/hypridle.conf);

          # Set noctalia wallpaper

          tanjiro = pkgs.fetchurl {
            name = "tanjiro";
            url = "https://github.com/kagurazakei/wallpapers/blob/main/1215947.jpg";
            hash = "sha256-9BypF+oea8eAzxleqBZI94JAjdcjWX+WLrPcOYYQnOM=";
          };
        in
        {
          ".config/hypr/hypridle.conf".text = quickidle;
          "wallpapers/schizomiku.jpg".source = tanjiro;
        };
    });
  };
}
