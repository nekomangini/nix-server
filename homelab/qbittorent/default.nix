{ lib, ... }:

{
  services.qbittorrent = {
    enable = true;
    group = "seanime"; # shares downloads with Seanime
    webuiPort = 8080; # the module default; Seanime's wizard pre-fills 8081, which is MeTube

    serverConfig = {
      LegalNotice.Accepted = true; # without this the service can't start
      BitTorrent.Session.DefaultSavePath = "/mnt/D/homelab/downloads/seanime";
      Preferences.WebUI = {
        Address = "127.0.0.1"; # only reachable from this machine
        LocalHostAuth = false; # Seanime's docs ask for "bypass authentication on localhost"
      };
    };
  };

  systemd.services.qbittorrent = {
    unitConfig.RequiresMountsFor = [ "/mnt/D/homelab/downloads/seanime" ];
    # group-writable files, so Seanime can rename and move what qBittorrent downloads
    serviceConfig.UMask = lib.mkForce "0002";
  };
}
