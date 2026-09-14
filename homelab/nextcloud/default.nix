{ pkgs, ... }:

{
  imports = [
    ./backup.nix
  ];

  systemd.tmpfiles.rules = [
    "d /mnt/D/homelab/nextcloud 0770 nextcloud nextcloud - -"
  ];

  systemd.services.nextcloud-setup.unitConfig.RequiresMountsFor = [ "/mnt/D" ];
  systemd.services.phpfpm-nextcloud.unitConfig.RequiresMountsFor = [ "/mnt/D" ];

  services.nextcloud = {
    enable = true;
    datadir = "/mnt/D/homelab/nextcloud";
    package = pkgs.nextcloud33;
    hostName = "nextcloud.home";
    https = false; # using http via Caddy

    database.createLocally = true; # provisions Postgres automatically
    configureRedis = true; # transactional file locking + caching
    maxUploadSize = "16G";

    config = {
      adminpassFile = "/run/agenix/nextcloud-admin";
      adminuser = "admin";
      dbtype = "pgsql"; # or "sqlite"
    };

    settings = {
      maintenance_window_start = 1;
      default_phone_region = "PH";
      log_type = "systemd";
      trusted_domains = [
        "nextcloud.home"
        "192.168.1.200"
      ];
      trusted_proxies = [ "127.0.0.1" ];
      overwriteprotocol = "http";
    };
  };

  # Override nextcloud's nginx to listen on 9600 instead of 80
  services.nginx.virtualHosts."nextcloud.home" = {
    listen = [
      {
        addr = "127.0.0.1";
        port = 9600;
      }
    ];
  };
}
