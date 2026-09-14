let
  # NOTE: To get the host public key execute cat /etc/ssh/ssh_host_ed25519_key.pub
  local = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZmGOztlgsKDd1foiIBpQIsMGAdxiWg9TlhSGgwHz1m";
  nekomangini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3G7EA0RM76fW1QA3eRrT+Kohxsh58IG47gonzCM+VQ";
in
{
  "homepage.env.age".publicKeys = [
    nekomangini
    local
  ];
  "netdata-discord.age".publicKeys = [
    nekomangini
    local
  ];
  "nextcloud-admin.age".publicKeys = [
    nekomangini
    local
  ];
}
