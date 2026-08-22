{ ... }:

{
  virtualisation.oci-containers.containers.metube = {
    image = "ghcr.io/alexta69/metube:latest";

    ports = [
      "8081:8081"
    ];

    volumes = [
      "/mnt/D/homelab/downloads/metube:/downloads"
    ];

    environment = {
      DOWNLOAD_DIR = "/downloads";
      # NOTE: Using yt-dlp nightly builds
      YTDL_NIGHTLY_UPDATE_TIME = "04:00";
    };

    autoStart = true;
  };
}
