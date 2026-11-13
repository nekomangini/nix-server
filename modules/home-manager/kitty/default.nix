{ config, ... }:

{
  imports = [
    # ./theme.nix
    ./settings.nix
    ./keybinds.nix
  ];
  programs.kitty = {
    enable = true;
    # theme = "Gruvbox Dark";

    extraConfig = ''
      # Include Noctalia generated theme
      include ${config.xdg.configHome}/kitty/themes/noctalia.conf
    '';
  };
}
