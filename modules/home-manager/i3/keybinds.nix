{
  pkgs,
  lib,
  config,
  ...
}:

let
  mod = "Mod4";
  ctrl = "Control";
  xdotool = "${pkgs.xdotool}/bin/xdotool";
  kitty = "${pkgs.kitty}/bin/kitty";
  dmenu = "${pkgs.dmenu}/bin/dmenu_run";
  # emacsclient = "${pkgs.emacs-gtk}/bin/emacsclient";
  emacsclient = "${config.myModules.emacs.package}/bin/emacsclient";
in

{
  imports = [
    ../../home-manager/shell/scripts.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      terminal = "kitty";

      keybindings = lib.mkOptionDefault {
        # ===== APPLICATIONS =====
        "${mod}+Return" = "exec ${kitty}";
        "${mod}+d" = "exec ${dmenu}";
        "${mod}+e" = "exec ${emacsclient} -c";

        # NOTE: Check modules/scripts/x11-powermenu.nix
        "${mod}+x" = "exec x-powermenu";

        # NOTE: Check modules/scripts/x11-webseach.nix
        "${mod}+b" = "exec x11-websearch";

        # ===== WINDOW MANAGEMENT =====
        "${mod}+q" = "kill";
        "${mod}+f" = "fullscreen toggle";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move windows
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Split
        "${mod}+period" = "split h";
        "${mod}+comma" = "split v";

        # Layouts
        "${mod}+s" = "layout stacking";
        "${mod}+t" = "layout tabbed";
        "${mod}+space" = "layout toggle split";

        # ===== WORKSPACE NAVIGATION =====
        "${mod}+Tab" = "workspace back_and_forth";
        "${mod}+backslash" = "workspace back_and_forth";
        "${mod}+u" = "[urgent=latest] focus";
        "${mod}+n" = "workspace next";
        "${mod}+p" = "workspace prev";

        # Workspaces 1-10
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # ==== MONITOR NAVIGATION ====
        # NOTE: Use mod+o and mod+i instead
        # "${mod}+comma" = "focus output left";
        # "${mod}+period" = "focus output right";

        # ===== SYSTEM =====
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+c" = "restart";
        "${mod}+Control+q" = "exec i3-msg exit";

        # ===== MULTIMEDIA =====
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";

        # ===== SCREENSHOTS =====
        # Imported from shell/scripts.nix
        # NOTE: Check modules/scripts/x11-screenshot.nix
        "Print" = "exec x-screenshot DVI";
        "Shift+Print" = "exec x-screenshot HDMI";
        "Alt+Print" = "exec x-screenshot DP";
        "Control+Print" = "exec x-screenshot BOTH";

        # Resize mode trigger
        "${mod}+r" = "mode resize";

        # ===== MOUSE EMULATION =====
        # Movement (H J K L)
        "${mod}+${ctrl}+h" = "exec ${xdotool} mousemove_relative -- -20 0";
        "${mod}+${ctrl}+j" = "exec ${xdotool} mousemove_relative -- 0 20";
        "${mod}+${ctrl}+k" = "exec ${xdotool} mousemove_relative -- 0 -20";
        "${mod}+${ctrl}+l" = "exec ${xdotool} mousemove_relative -- 20 0";

        # Clicks
        "${mod}+${ctrl}+comma" = "exec ${xdotool} click --clearmodifiers 1";
        "${mod}+${ctrl}+period" = "exec ${xdotool} click --clearmodifiers 3";
        "${mod}+${ctrl}+y" = "exec ${xdotool} click --clearmodifiers 4"; # Scroll Wheel UP
        "${mod}+${ctrl}+p" = "exec ${xdotool} click --clearmodifiers 5"; # Scroll Wheel DOWN

        # Diagonal Movement
        "${mod}+${ctrl}+u" = "exec ${xdotool} mousemove_relative -- -40 -40";
        "${mod}+${ctrl}+i" = "exec ${xdotool} mousemove_relative -- 40 -40";
        "${mod}+${ctrl}+n" = "exec ${xdotool} mousemove_relative -- -40 40";
        "${mod}+${ctrl}+m" = "exec ${xdotool} mousemove_relative -- 40 40";

      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize shrink height 10 px or 10 ppt";
          "Up" = "resize grow height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

    };
  };
}
