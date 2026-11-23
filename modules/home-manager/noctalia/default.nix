{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";

        templates = {
          enable_community_templates = true;
          community_ids = [ "vivaldi" ];
        };
      };

      widget.workspaces = {
        style = "regular";
        show_labels = false;
        hide_when_empty = true;
        monitors = [ ];
      };

      bar.default = {
        position = "right";
        start = [
          "launcher"
          "wallpaper"
          "workspaces"
        ];
        center = [ "clock" ];
        end = [
          "media"
          "tray"
          "notifications"
          "clipboard"
          "bluetooth"
          "volume"
          "control-center"
          "session"
        ];

        monitor.hdmi = {
          match = "HDMI-A-1";
          position = "top";
          start = [ "workspaces" ];
          center = [ "media" ];
          end = [
            "clock"
            "volume"
            "session"
          ];
        };

        monitor.dvi = {
          match = "DVI-D-1";
          position = "right";
        };
      };

      wallpaper = {
        enabled = true;
        # directory = "${config.home.homeDirectory}/nix-server/wallpaper";
        directory = "/mnt/D/media/Images/Wallpaper";
      };

      recommendedServices.enable = true;
    };
  };
}
