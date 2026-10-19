{ pkgs, lib, ... }:

{
  imports = [
    # === EDITORS ===
    ../../modules/home-manager/emacs/doom.nix
    # TODO:
    ../../modules/home-manager/kakoune.nix

    # === SHELL ===
    # TODO:
    ../../modules/home-manager/shell/fish
  ];

  home = {
    username = "nekomangini-omarchy";
    homeDirectory = "/home/nekomangini-omarchy";
    stateVersion = "25.05";

    packages = with pkgs; [
      htop
      zellij
    ];
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = lib.mkForce "emacsclient -t"; # terminal
    VISUAL = lib.mkForce "emacsclient -c"; # GUI
    ALTERNATE_EDITOR = "";
  };
}
