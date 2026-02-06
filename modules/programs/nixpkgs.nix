# Common Programs used by hosts
{
  inputs,
  config,
  pkgs,
  lib,
  users,
  ...
}:
{

  # Options maker
  options.kagurazakei.programs = {
    core.enable = lib.mkEnableOption "enable core programs";

    desktop.enable = lib.mkEnableOption "enable desktop programs";

    heavy.enable = lib.mkEnableOption "enable heavy/demanding programs";
  };

  # Config selector
  config = lib.mkMerge [

    # Core programs
    (lib.mkIf (config.kagurazakei.programs.core.enable && config.kagurazakei.programs.enable) {
      environment.systemPackages = with pkgs; [
        btop # hardware monitor
        tree # enables tree view in terminal
        unzip # unzip cli utility
        fzf # Fuzzy finder
        npins # Npins source manager
        speedtest-cli # internet speedtest cli utility
        nwg-look
      ];

      # Enables intel gpu monitoring
      security.wrappers.btop = {
        owner = "root";
        group = "root";
        source = lib.getExe pkgs.btop;
        capabilities = "cap_perfmon+ep";
      };
    })

    # Desktop applications
    (lib.mkIf (config.kagurazakei.programs.desktop.enable && config.kagurazakei.programs.enable) {
      environment.systemPackages = with pkgs; [

        qimgv # image viewer
        wineWowPackages.waylandFull # wine
        xournalpp # note taking
        mpv # media player
        gparted # disk management software
        gnome-calculator # calculator
        moonlight-qt # Remote to Windows GPU-Passthru
        rose-pine-gtk-theme # Rose-Pine Gtk Theme
        slurp # area selection tool used for wl-screenrec
        wl-clipboard # clipboard manager
        wl-screenrec # screen recorder
        brightnessctl # brightness ctl
        wlsunset # I need fucking blue light filter, my fucking eyes hurt
        ddcutil # Manipulating external monitors using i2c bus
        zpkgs.scripts.npins-show # npins-show command
        wo.nahidacursor # Cursor Package
        wo.papiteal # Papirus Teal Icons
        wo.vesktop # Vesktop with overrides
        kdePackages.dolphin
        zathura
        gtk-engine-murrine
        pavucontrol
        zoxide
        zellij
        unzip
        swww
        gtk3
        gtk4
        atuin
        zoxide
        dart-sass
        sass
        wf-recorder
        sassc
        libgtop
        gtk4
        vivid
        gpu-screen-recorder
        libqalculate
        dbus-glib
        gtkmm4
        nwg-look
        viu
        # Noctalia Shell
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      # Core desktop services
      security.polkit.enable = true;
      programs.xwayland.enable = true;
      services.gnome.gnome-keyring.enable = true;

      # Theme gtk apps
      programs.dconf.profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "rose-pine";
              icon-theme = "Papirus-Dark";
              cursor-theme = "Yuurei-Angel";
              document-font-name = "JetBrainsMono Nerd Font";
              font-name = "JetBrainsMono Nerd Font";
              monospace-font-name = "CaskaydiaMono NF";
              color-scheme = "prefer-dark";
              clock-show-weekday = true;
            };
          };
        }
      ];

      # Correct gtk theming for apps that don't use runtime directory
      hjem.users = lib.genAttrs users (user: {
        files =
          let
            themeName = "rose-pine";
            themeDir = "${pkgs.rose-pine-gtk-theme}/share/themes/${themeName}/gtk-4.0";
          in
          {
            ".config/gtk-4.0/assets".source = "${themeDir}/assets";
            ".config/gtk-4.0/gtk.css".source = "${themeDir}/gtk.css";
            ".config/gtk-4.0/gtk-dark.css".source = "${themeDir}/gtk-dark.css";
          };
      });
    })

    # Large/Demanding applications
    (lib.mkIf (config.kagurazakei.programs.heavy.enable && config.kagurazakei.programs.enable) {

      environment.systemPackages = with pkgs; [
        gimp # GIMP image manipulator
        kicad-small # KiCAD Electronic schematic/PCB designer
        rare # GUI based on legendary which is a port of Epic Games
        prismlauncher # minecraft
        # davinci-resolve                 # Davinci-resolve video editor
        audacity # temp replacement
        # Davinci derivation patched (－ˋ⩊ˊ－) (fails to build tho :woe:)
        # (pkgs.callPackage ./davinci.nix {})
      ];
    })
  ];
}
