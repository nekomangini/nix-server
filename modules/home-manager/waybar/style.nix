{
  programs.waybar.style = ''
    /* Cyber-Emerald Theme (Custom Matched to Wallpaper) */
    * {
    margin: 0;
    padding: 0;
    border: none;
    border-radius: 0;
    font-family: "FiraCode Nerd Font", "Cascadia Code", monospace;
    font-size: 12px;
    min-height: 0;
    }

    /* Palette sampled from cats_008.jpg */
    @define-color fg #a3b8b5;
    @define-color red #ff4d4d;
    @define-color neon_cyan #43f2d6;
    @define-color emerald #5fc497;
    @define-color blue #36a3d9;
    @define-color aqua #95e6cb;
    @define-color orange #f29718;
    @define-color grey0 #2a3b38;
    @define-color grey1 #40524f;
    @define-color grey2 #5c706d;
    @define-color bg_dim #080c0c;
    @define-color bg0 #0a1211;
    @define-color bg1 #121f1d;
    @define-color bg2 #1a2b28;

    /* Main Bar */
    #waybar {
      background: rgba(10, 18, 17, 0.92);
      border-bottom: 2px solid rgba(67, 242, 214, 0.3); /* Subtle cyan underline */
      border-radius: 0px;
    }

    /* Container Spacing */
    #modules-left,
    #modules-center,
    #modules-right {
      background: transparent;
      padding: 4px 6px;
    }

    /* Custom Launcher */
    #custom-launcher {
      color: @neon_cyan;
      font-size: 20px;
      padding: 5px 0 5px 0;
    }

    /* Workspaces */
    #workspaces {
      border-radius: 10px;
      padding: 3px 0 3px 0;
      margin-right: 10px;
    }

    #workspaces button {
      background: rgba(18, 31, 29, 0.6);
      color: @grey2;
      padding: 4px 11px;
      margin: 3px 3px;
      border-radius: 4px;
      border: 1px solid rgba(67, 242, 214, 0.1);
      font-weight: 500;
      min-width: 28px;
      transition: all 300ms ease;
    }

    #workspaces button:hover {
      background: rgba(26, 43, 40, 0.8);
      color: @fg;
      border-color: @emerald;
    }

    #workspaces button.active {
      background: @neon_cyan;
      color: @bg0;
      font-weight: 700;
      border: 1px solid @neon_cyan;
      /* Neon glow effect matched to the sign on the left */
      box-shadow: 0 0 12px rgba(67, 242, 214, 0.6);
    }

    #workspaces button.urgent {
      background: @red;
      color: @bg0;
      border-color: @red;
    }

    /* Remove empty Workspace(waybar 0.15.0) */
    #workspaces button#niri-workspace-4.empty {
    min-width: 0;
    margin: 0;
    padding: 0;
    font-size: 0;
    opacity: 0;
    }

    /* Clock */
    #clock {
      background: @bg1;
      color: @neon_cyan;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 4px;
      letter-spacing: 0.05em;
      border: 1px solid rgba(67, 242, 214, 0.2);
      font-weight: 600;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
    }

    /* Stat Modules */
    #temperature,
    #custom-gpu-temp,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray {
      background: @bg1;
      color: @fg;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 4px;
      border: 1px solid rgba(95, 196, 151, 0.15); /* Emerald border */
      transition: all 200ms ease;
    }

    #temperature:hover,
    #custom-gpu-temp:hover,
    #cpu:hover,
    #memory:hover,
    #network:hover,
    #pulseaudio:hover {
      background: @bg2;
      border-color: @neon_cyan;
      color: @neon_cyan;
    }

    /* Critical States */
    #temperature.critical,
    #custom-gpu-temp.critical,
    #cpu.critical,
    #memory.critical {
      background: @red;
      color: @bg0;
      border-color: @red;
    }

    /* Muted Audio State */
    #pulseaudio.muted {
      background: @bg1;
      color: @grey1;
      border-color: @grey0;
    }

    /* System Tray */
    #tray {
      padding: 4px 11px;
      margin: 5px 5px;
    }

    /* Custom Control (Power) */
    #custom-control {
      color: @neon_cyan;
      font-size: 16px;
      padding: 4px 11px;
      margin: 5px 5px;
      background: @bg1;
      border-radius: 4px;
      border: 1px solid rgba(67, 242, 214, 0.2);
    }

    #custom-control:hover {
      background: @red;
      color: @bg0;
      border-color: @red;
    }


  '';
}
