{ ... }:

{
  # syncthing
  services.syncthing = {
    enable = true;
    user = "nekomangini";
    dataDir = "/mnt/D/homelab/sync";
    configDir = "/home/nekomangini/.config/syncthing";
    openDefaultPorts = true;

    guiAddress = "0.0.0.0:8384";

    settings = {
      folders = {
        "notes" = {
          path = "/mnt/D/notes";
          devices = [
            "SM-A057F"
            "vivo-1920"
            "void-nekomangini"
          ];
        };
      };

      devices = {
        "SM-A057F" = {
          id = "GOXVTWV-7DMTWCL-ZIJUV4K-IOPPZFK-O42NWT6-HBYSGWW-LPQQZYC-ATJ2NQR";
        };
        "vivo-1920" = {
          id = "26TUQQW-EDFBM26-TT4X7KL-5VZCNGY-QFJD3TW-FO7XOBU-OVA7SKD-FIZSZQF";
        };
        "void-nekomangini" = {
          id = "HR33SED-ARJB5UU-R3FCZE5-WGCRGC3-CEI7KYW-2RSEKQL-VCLDSUF-XPZUMQJ";
        };
      };
    };

  };
}
