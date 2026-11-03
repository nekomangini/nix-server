{ pkgs, ... }:
let
  wallpapers = ../../../wallpaper;
  qtileAutostart = pkgs.writeShellApplication {
    name = "qtile-autostart";
    runtimeInputs = with pkgs; [
      xrandr
      feh
      picom
      dunst
      kitty
      kdePackages.polkit-kde-agent-1
    ];
    text = ''
      # NOTE: 3 MONITORS SETUP
      # Monitors
      xrandr --output DP-1 --mode 1360x768 --pos 0x0 \
             --output HDMI-0 --mode 1920x1080 --pos 1360x0 --rotate right \
             --output DVI-D-0  --mode 1920x1080 --pos 2440x0 

      # Wallpapers
      feh --bg-fill ${wallpapers}/cars_034.png \
                    ${wallpapers}/space_009_h.jpg \
                    ${wallpapers}/cars_036.jpg &

      # Compositor and notifications
      picom &
      dunst &
      kitty &

      # Staggered apps
      # (sleep 3 && io.github.alainm23.planify) &
      # (sleep 5 && dolphin) &
      # (sleep 7 && vivaldi) &
    '';
  };
in
{
  home.packages = [ qtileAutostart ];
}
