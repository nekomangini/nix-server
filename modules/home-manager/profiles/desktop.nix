{ config, ... }:

{
  imports = [
    ../kitty
    ../shell
    ../helix
    ../emacs.nix
    ../neovim/astronvim.nix
    ../neovide
    ../tmux.nix
    ../vim.nix
    ../kakoune.nix
    ../git.nix
    ../yazi.nix

    ../packages
    ../android.nix
    ../ruby
    ../../../packages
    ../kdeconnect.nix

    ../qtile
    ../i3
    ../dunst
    ../hyprland
    ../niri
    ../hyprpaper.nix
    ../kanshi
    ../waybar
    ../foot
    ../zellij
    ../alacritty
    ../fuzzel.nix
    ../hyprlock.nix
    ../ydotool.nix
  ];

  # ndir path
  myModules.ndir.directories = [
    "/home/nekomangini/nix-server"
    "/mnt/D/dev/01-projects"
    "/mnt/D/dev/02-areas/scripts"
    "/mnt/D/notes"
    "/mnt/D/game-development"
    "${config.home.homeDirectory}/.config/nekovim"
    "${config.home.homeDirectory}/.config/astronvim-v5"
  ];

  home = {
    username = "nekomangini";
    homeDirectory = "/home/nekomangini";
    stateVersion = "26.05";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    # EDITOR = "${pkgs.helix}/bin/hx";
    # VISUAL = "${pkgs.helix}/bin/hx";
    # TMUX_PATHS_FILE = "/run/agenix/tmux-manager-paths";
    # TEST: Check if krita runs using this code
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  # NOTE Only add this if you ever need pure X11 emacs:
  # myModules.emacs.package = pkgs.emacs-gtk;
}
