{ pkgs, config, ... }:

{
  imports = [
    ../../modules/home-manager/kitty
    ../../modules/home-manager/shell
    ../../modules/home-manager/helix
    ../../modules/home-manager/emacs
    ../../modules/home-manager/neovim
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/vim.nix
    ../../modules/home-manager/kakoune.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/yazi.nix

    ../../modules/home-manager/packages
    ../../modules/home-manager/android.nix
    ../../modules/home-manager/ruby
    ../../packages
    ../../modules/home-manager/kdeconnect.nix

    ../../modules/home-manager/qtile
    ../../modules/home-manager/i3
    ../../modules/home-manager/dunst
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/niri

    ../../modules/home-manager/hyprpaper.nix
    ../../modules/home-manager/kanshi
    ../../modules/home-manager/waybar
    ../../modules/home-manager/foot
    ../../modules/home-manager/zellij
    ../../modules/home-manager/zellij
    ../../modules/home-manager/alacritty
    ../../modules/home-manager/fuzzel.nix
    ../../modules/home-manager/hyprlock.nix
    ../../modules/home-manager/ydotool.nix
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

  myModules.emacs = {
    package = pkgs.emacs-pgtk;
    enableDartFlutter = true;
  };

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
    # NOTE: hint Electron apps to use wayland
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  # NOTE Only add this if you ever need pure X11 emacs:
  # myModules.emacs.package = pkgs.emacs-gtk;
}
