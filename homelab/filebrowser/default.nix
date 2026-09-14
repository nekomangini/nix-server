{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.filebrowser ];

  systemd.services.filebrowser = {
    description = "FileBrowser file server";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.filebrowser}/bin/filebrowser \
          --address 0.0.0.0 \
          --port 8085 \
          --root /mnt/D/homelab/filebrowser \
          --database /mnt/D/homelab/filebrowser/filebrowser.db
      '';
      Restart = "on-failure";
      User = "nekomangini";
      Group = "users";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8085 ];
}
