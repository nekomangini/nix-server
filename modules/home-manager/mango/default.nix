{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix-server";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile."mango/config.conf" = {
    source = symlink "${dotfiles}/modules/home-manager/mango/config.conf";
  };

  # Only mango-specific packages not configured elsewhere
  # home.packages = with pkgs; [
  #   # e.g. wlr-randr, grim, slurp
  # ];

  # If your emacs module defines per-compositor sessions, like niri:
  myModules.emacs.sessions.mango = pkgs.emacs-pgtk;
}
