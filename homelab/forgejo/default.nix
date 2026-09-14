{ ... }:

{
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "forgejo.home";
        HTTP_PORT = 3002;
        ROOT_URL = "http://forgejo.home/";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      # CI/CD
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3002 ];
}
