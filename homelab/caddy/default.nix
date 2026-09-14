{ ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://jellyfin.home" = {
        extraConfig = "reverse_proxy localhost:8096";
      };
      "http://immich.home" = {
        extraConfig = "reverse_proxy localhost:2283";
      };
      "http://navidrome.home" = {
        extraConfig = "reverse_proxy localhost:4533";
      };
      "http://kavita.home" = {
        extraConfig = "reverse_proxy localhost:3020";
      };
      "http://linkding.home" = {
        extraConfig = "reverse_proxy localhost:9090";
      };
      "http://radicale.home" = {
        extraConfig = "reverse_proxy localhost:5232";
      };
      "http://wikijs.home" = {
        extraConfig = "reverse_proxy localhost:3005";
      };
      "http://jotty.home" = {
        extraConfig = "reverse_proxy localhost:3030";
      };
      "http://uptime.home" = {
        extraConfig = "reverse_proxy localhost:3001";
      };
      "http://forgejo.home" = {
        extraConfig = "reverse_proxy localhost:3002";
      };
      "http://syncthing.home" = {
        extraConfig = "reverse_proxy localhost:8384";
      };
      "http://metube.home" = {
        extraConfig = "reverse_proxy localhost:8081";
      };
      "http://adguard.home" = {
        extraConfig = "reverse_proxy localhost:3004";
      };
      "http://dashboard.home" = {
        extraConfig = "reverse_proxy localhost:3333";
      };
      "http://netdata.home" = {
        extraConfig = "reverse_proxy localhost:19999";
      };
      "http://nextcloud.home" = {
        extraConfig = "reverse_proxy localhost:9600";
      };

      "http://filebrowser.home" = {
        extraConfig = "reverse_proxy localhost:8085";
      };

    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
