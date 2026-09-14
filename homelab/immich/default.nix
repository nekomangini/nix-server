{ ... }:

{
  services.immich = {
    enable = true;
    openFirewall = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "/mnt/D/homelab/media/photos/immich";

    settings = null;
  };

  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.redis.servers.immich.logLevel = "warning";
}
