{ pkgs, ... }:

{
  xsession.windowManager.i3.config.startup = [
    # ===== SYSTEM SERVICES =====
    # TODO
    # {
    #   command = "dex-autostart --autostart --environment i3";
    #   notification = false;
    # }
    # {
    #   command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
    #   notification = false;
    # }
    # {
    #   command = "nm-applet";
    #   notification = false;
    # }

    # ===== COMPOSITOR & WALLPAPER =====
    # NOTE: I'll enable this when I just want to look at my wallpaper and not work :)
    # {
    #   command = "picom";
    #   notification = false;
    # }
    # {
    #   # FIX
    #   # command = "feh --bg-fill ~/nix-server/wallpaper/cars_036.jpg ~/nix-server/wallpaper/itachi_014.jpg";
    #   command = "feh --no-xinerama --bg-fill ~/nix-server/wallpaper/cars_036.jpg";
    #   notification = false;
    # }

    # ===== NOTIFICATION & STATUS BAR =====
    {
      command = "dunst";
      notification = false;
    }

    # ===== POLKIT AGENT =====
    {
      command = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      notification = false;
    }

    # ===== EMACS DAEMON =====
    # NOTE: Using systemd
    # {
    #   command = "emacs --daemon=nekoserver";
    #   notification = false;
    # }

    # ===== MONITOR SETUP ====
    {
      # NOTE: 1 MONITOR SETUP
      # command = "xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate normal &";
      # NOTE: 2 MONITORS SETUP
      # command = "xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right &";
      command = "xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right";
      # NOTE: 3 MONITORS SETUP
      # command = "xrandr --output DP-1 --mode 1360x768 --pos 0x0 --output DVI-D-0 --mode 1920x1080 --pos 1360x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 3280x0 --rotate right &";
      # command = "xrandr --output DP-1 --mode 1920x1080 --pos 0x0 --output DVI-D-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 3840x0 --rotate right &";
    }

    # ===== STARTUP APPLICATIONS =====
    {
      command = "exec ${pkgs.kitty}/bin/kitty";
      notification = false;
    }
    # {
    #   command = "exec ${pkgs.ticktick}/bin/ticktick";
    #   notification = false;
    # }
    {
      command = "sleep 5 && exec ${pkgs.kdePackages.dolphin}/bin/dolphin";
      notification = false;
    }
    {
      command = "sleep 7 && exec ${pkgs.brave}/bin/brave";
      notification = false;
    }
  ];
}
