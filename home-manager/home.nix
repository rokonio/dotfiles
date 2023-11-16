{ config, pkgs, nixgl, ... }:
let
 mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in 
{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rokonio";
  home.homeDirectory = "/home/rokonio";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # pkgs.mesa-demos
    # pkgs.nixgl.auto.nixGLDefault
    # pkgs.nixgl.auto.nixGLNvidia
    # pkgs.nixgl.auto.nixGLNvidiaBumblebee
    # pkgs.nixgl.nixGLIntel
    # pkgs.nixgl.auto.nixVulkanNvidia
    # pkgs.nixgl.nixVulkanIntel

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.rustup
    pkgs.lld # For faster linking in rust compilation
    pkgs.clang

    pkgs.marksman
    pkgs.dprint

    pkgs.typst
    pkgs.typst-lsp
    pkgs.typst-fmt

    pkgs.python38
  ];
  
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.helix = {
    enable = true;
    extraPackages = [
      # Enable interaction with system clipboard
      pkgs.xsel
    ];
  };


  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.enable = true;
  xdg.configFile = {
    "helix/config.toml".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/helix/config.toml";
    "helix/languages.toml".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/helix/languages.toml";
    "helix/runtime/queries".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/helix/runtime/queries";
    "home-manager".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };


  nixpkgs.config.allowUnfree = true;

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rokonio/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "hx";

    # Clean up home dotfiles as much as possible
    # XDG_CONFIG_HOME="$HOME/.config";
    # XDG_DATA_HOME="$HOME/.local/share";
    # XDG_CACHE_HOME="$HOME/.cache";
    # XDG_STATE_HOME="$HOME/.local/state";
    PYTHONUSERBASE="$HOME/.local/share/python";
    PYTHONPYCACHEPREFIX="$HOME/.cache/python";
    RUSTUP_HOME="$HOME/.local/share/rustup";
    CARGO_HOME="$HOME/.local/share/cargo";
  };

  home.shellAliases = {
    "nvidia-settings" = "nvidia-settings --config=\"$XDG_CONFIG_HOME\"/nvidia/settings";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
