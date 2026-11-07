{ config, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      bar.default = {
        position = "right";
        monitor.hdmi = {
          match = "HDMI-A-1";
          position = "top";
        };
      };

      wallpaper = {
        enabled = true;
        directory = "${config.home.homeDirectory}/nix-server/wallpaper";
      };

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };
  };
}
