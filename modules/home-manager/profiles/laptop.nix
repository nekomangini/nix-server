{ pkgs, ... }:

{
  imports = [
    # === EDITORS ===
    ../helix
    ../emacs.nix
    ../neovim/astronvim.nix
    ../vim.nix
    ../kakoune.nix

    # === SHELL ===
    ../shell/fish
    ../shell/scripts.nix

    # === TERMINAL ===
    ../kitty

    # === TOOLS ===
    ../git.nix
    ../tmux.nix
    ../yazi.nix

    # === WINDOW MANAGER ===
    ../i3
    ../dunst
    ../rofi.nix

    # === SCRIPTS ===
    # ../packages.nix
  ];

  # Override emacs to use GTK (X11) instead of pgtk (Wayland)
  myModules.emacs = {
    package = pkgs.emacs-gtk;
    enableDartFlutter = false;
  };

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
    VISUAL = "${pkgs.helix}/bin/hx";
  };

  home.packages = with pkgs; [
    fd
    ripgrep
    fzf
    zoxide
    eza
    fastfetch
    htop
    xclip
    unzip
    neovim
    zellij
  ];
}
