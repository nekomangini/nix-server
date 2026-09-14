{
  age = {
    # identityPaths = [ "/home/nekomangini/.ssh/id_ed25519" ]; # requires passphrase
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # no passphrase
    secrets = {
      "homepage.env" = {
        file = ../../../secrets/homepage.env.age;
        owner = "nekomangini";
      };
      "netdata-discord" = {
        file = ../../../secrets/netdata-discord.age;
        owner = "netdata";
        group = "netdata";
        mode = "0640";
      };
      "nextcloud-admin" = {
        file = ../../../secrets/nextcloud-admin.age;
        owner = "nekomangini";
      };
    };
  };
}
