{ pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./rules.nix
    ./panel.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [ ];
    };

    # NOTE: The i3status bar is only visible on DVI-D-0 monitor(Horizontal monitor)
    extraConfig = ''
      bar {
        position bottom
        status_command ${pkgs.i3status}/bin/i3status -c ~/.config/i3status/config
        output DVI-D-0
        
        colors {
          background #000000
          statusline #ffffff
          separator  #666666
          
          focused_workspace  #4c7899 #285577 #ffffff
          active_workspace   #333333 #5f676a #ffffff
          inactive_workspace #333333 #333333 #ffffff
          urgent_workspace   #2f343a #900000 #ffffff
        }
      }
    '';
  };

  myModules.emacs.sessions.i3 = pkgs.emacs-gtk;
}
