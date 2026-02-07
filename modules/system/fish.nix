{
  pkgs,
  lib,
  config,
  users,
  sources,
  user,
  ...
}:

let
  rebuildCommand = "nixos-rebuild --flake ~/nixos# -S";
  dot = config.hjem.users.${user}.impure.dotsDir;
in
{

  options.kagurazakei.system.fish.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf (config.kagurazakei.system.fish.enable && config.kagurazakei.system.enable) {

    # Enables users to use the shell
    users.users = lib.genAttrs (users ++ [ "root" ]) (usershell: {
      shell = pkgs.fish;
    });

    # man-cache is too annoying
    documentation.man.generateCaches = false;

    # Extensive fish shell stuff
    programs.fish = {
      enable = true;

      # Removes bash script reliance for nix startups
      useBabelfish = true;

      # Abbreviations to expand commands with simple keywords
      shellAbbrs = {

        # nix stuff
        snr = rebuildCommand;
        ns = "nix shell nixpkgs#";
        nr = "nix run nixpkgs#";
        nb = "nix build nixpkgs#";

        # git stuff
        gaa = "git add --all";
        ga = "git add";
        gs = "git status";
        gc = "git commit";
        gcm = ''git commit -m "$hostname:'';
        gck = "git checkout -b";
        gp = "git push";
        gpu = "git pull";
        gsw = "git switch";
        gca = "git commit --amend";
        gcp = "git cherry-pick";
        grsa = "git restore --staged .";
        grs = "git restore --staged";
        gr = "git restore";
        gra = "git restore .";
        gd = "git diff";
        gds = "git diff --staged";
        gl = "git log";

        # misc

      };

      # Aliases to execute commands directly
      shellAliases = {
        ls = "eza --icons --group-directories-first -1";

        v = "nvim";
        sv = "sudo -E nvim";
        ga = "git add .";
        fm = "yazi";
        snowball = "${rebuildCommand} boot";
        snowfall = "${rebuildCommand} switch";
        snowstorm = "${rebuildCommand} test";
        snowshed = "${rebuildCommand} dry-build";
        schizo = "ssh antonio@hana";
        libre = "ssh sumee@kaolin";
        deployin = "${rebuildCommand} --use-substitutes --target-host sumee@kaolin boot";
        deployer = "${rebuildCommand} --build-host sumee@verdure --target-host sumee@verdure boot";
      };

      # Coloring shell, referenced from Zaphkiel config
      interactiveShellInit = ''

        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
        set sponge_purge_only_on_exit true
          set fish_greeting
          set fish_cursor_insert line blink

          function fish_user_key_bindings
            bind --mode insert alt-c 'cdi; commandline -f repaint'
            bind --mode insert alt-f 'fzf-file-widget'
          end

          # hydro (prompt) stuff
          set -g hydro_symbol_start
          set -U hydro_symbol_git_dirty "*"
          set -U fish_prompt_pwd_dir_length 0
          function fish_mode_prompt; end;
          function update_nshell_indicator --on-variable IN_NIX_SHELL
            if test -n "$IN_NIX_SHELL";
              set -g hydro_symbol_start "impure "
            else
              set -g hydro_symbol_start
            end
          end
          update_nshell_indicator

          # smoll script to get the store path given an executable name
          function store_path -a package_name
            which $package_name 2> /dev/null | path resolve | read -l package_path
            if test -n "$package_path"
              echo (path dirname $package_path | path dirname)
            end
          end
      '';
    };

    # Zoxide, faster change directory
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # Fish integration
    programs.direnv.enableFishIntegration = true;
    programs.starship.enable = true;
    # CNF
    programs.command-not-found.enable = false;

    # Fuzzy Finder keybinds
    programs.fzf.keybindings = true;

    # Fish dependancies
    environment.systemPackages = with pkgs; [
      fishPlugins.done
      fishPlugins.sponge
      fishPlugins.hydro
      carapace
      starship
      eza
      krabby
      atuin
      nix-your-shell
      any-nix-shell
      fish-lsp
      babelfish
      g-ls
      stylua
      dwt1-shell-color-scripts
    ];
  };
}
