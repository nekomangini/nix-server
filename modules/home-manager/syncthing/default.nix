{ ... }:

{
  services.syncthing = {
    enable = true;

    # Home Manager manages the GUI address; no firewall options here.
    guiAddress = "127.0.0.1:8384";

    settings = {
      folders = {
        "notes" = {
          # This is the LOCAL path on the laptop, not the server path.
          path = "/home/nekomangini-omarchy/notes";

          # Reuse the exact device IDs from your server config.
          devices = [
            "SM-A057F"
            "vivo-1920"
            "sylphiette"
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
        "sylphiette" = {
          id = "54VO5WS-EPE236P-5KNBNKO-CN4KYMA-VUPV55U-GHCWPOD-JR64OYF-APW77QP";
        };
      };
    };
  };
}
