{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix-server";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in

{
  xdg.configFile."qtile" = {
    source = symlink "${dotfiles}/modules/home-manager/qtile/config";
  };

  imports = [
    ../rofi.nix
    ../picom.nix
    ./qtile-autostart.nix
  ];
}
