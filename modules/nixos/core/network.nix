{ ... }:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  networking = {
    hostName = "sylphiette";
    useDHCP = false;

    # Disable NetworkManager since because I'm setting the static IP manually
    networkmanager.enable = false;

    interfaces.enp3s0.ipv4.addresses = [
      {
        address = "192.168.1.200"; # safe IP outside typical DHCP range
        prefixLength = 24;
      }
    ];

    defaultGateway = "192.168.1.1";
    nameservers = [
      "192.168.1.200"
      "94.140.14.15"
    ];
  };

  # TEST:
  # mDNS so I can use neko-desktop.local instead of IP
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
