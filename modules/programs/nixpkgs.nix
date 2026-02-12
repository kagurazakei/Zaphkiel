# Common Programs used by hosts
{
  inputs,
  config,
  pkgs,
  lib,
  users,
  sources,
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
        nix-your-shell
        ani-cli
        pokemon-colorscripts
        rofi
        krabby
        g-ls
        carapace
        carapace-bridge
        app2unit
        any-nix-shell
        bat
        duf
        tree # enables tree view in terminal
        unzip # unzip cli utility
        fzf # Fuzzy finder
        npins # Npins source manager
        speedtest-cli # internet speedtest cli utility
        nwg-look
        vscodium
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
        # wineWowPackages.waylandFull # wine
        # xournalpp # note taking
        inputs.firefox.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        catppuccin-kde
        komikku
        tmux
        zellij
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
        wo.cursors
        wo.catMocha-icons
        wo.viu-custom
        sources.kureiji-ollie-cursors
        inputs.waifu-cursors.packages.${pkgs.stdenv.hostPlatform.system}.all
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
        libadwaita
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
      ];

      # Core desktop services
      security.polkit.enable = true;
      programs.xwayland.enable = true;
      services.gnome.gnome-keyring.enable = true;

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
