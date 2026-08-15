{ pkgs, ... }:

{
  # Install ydotool
  home.packages = with pkgs; [
    ydotool
  ];

  # User systemd service (from forum post)
  systemd.user.services.ydotoold = {
    Unit = {
      Description = "An auto-input utility for wayland";
      Documentation = [
        "man:ydotool(1)"
        "man:ydotoold(8)"
      ];
    };

    Service = {
      Type = "simple";
      Restart = "on-failure";
      ExecStart = "${pkgs.ydotool}/bin/ydotoold --socket-path /tmp/ydotools";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Set environment variable for the socket
  home.sessionVariables = {
    YDOTOOL_SOCKET = "/tmp/ydotools";
  };
}
