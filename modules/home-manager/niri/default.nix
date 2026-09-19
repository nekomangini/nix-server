{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix-server";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in

{
  xdg.configFile."niri/config.kdl" = {
    source = symlink "${dotfiles}/modules/home-manager/niri/config.kdl";
  };

  # Only add niri-specific packages that aren't already configured elsewhere
  home.packages = with pkgs; [
    awww
  ];
}
