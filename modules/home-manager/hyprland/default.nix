{ config, lib, ... }:

let
  hyprDir = "${config.home.homeDirectory}/nix-server/modules/home-manager/hyprland/config";
  luaFiles = lib.filter (lib.hasSuffix ".lua") (builtins.attrNames (builtins.readDir ./config));
in

{
  imports = [ ../shell/scripts.nix ];

  xdg.configFile = lib.listToAttrs (
    map (f: {
      name = "hypr/${f}";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${hyprDir}/${f}";
        force = true;
      };
    }) luaFiles
  );
}
