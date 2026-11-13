{ lib, pkgs, ... }:

{
  users.users.seanime = {
    isSystemUser = true;
    group = "seanime";
    home = "/var/lib/seanime";
  };
  users.groups.seanime = { };

  # /mnt/D/homelab is owned by nekomangini, so create this one for seanime
  systemd.tmpfiles.rules = [
    "d /mnt/D/homelab/downloads/seanime 0775 seanime seanime - -"
  ];

  systemd.services.seanime = {
    description = "Seanime";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    unitConfig.RequiresMountsFor = [ "/mnt/D/homelab/downloads/seanime" ];

    path = [ pkgs.ffmpeg ];

    # Host 127.0.0.1 and port 43211 are already the config.toml defaults
    environment.SEANIME_DATA_DIR = "/var/lib/seanime";

    serviceConfig = {
      ExecStart = lib.getExe pkgs.seanime;
      User = "seanime";
      Group = "seanime";
      StateDirectory = "seanime";
      WorkingDirectory = "/var/lib/seanime";
      Restart = "on-failure";
    };
  };
}
