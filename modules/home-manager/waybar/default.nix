{ ... }:

{
  imports = [
    ./modules.nix
    ./style.nix
  ];

  programs.waybar = {
    enable = true;

    settings = {
      # DVI-D-1: code / art / ide
      mainBar = {
        output = [ "DVI-D-1" ];
        layer = "top";
        spacing = 0;
        height = 0;
        margin-top = 0;
        margin-right = 0;
        margin-bottom = 0;
        margin-left = 0;

        modules-left = [
          "custom/launcher"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "network"
          "pulseaudio"
          "custom/control"
        ];
      };

      # HDMI-A-1 (portrait): term / files / read
      hdmiBar = {
        output = [ "HDMI-A-1" ];
        layer = "top";
        spacing = 0;
        height = 0;
        margin-top = 0;
        margin-right = 0;
        margin-bottom = 0;
        margin-left = 0;

        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "temperature"
          "custom/gpu-temp"
          "cpu"
          "memory"
        ];
      };
    };
  };
}
