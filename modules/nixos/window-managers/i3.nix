{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;

      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock-color
        # alsa-utils
        # xss-lock
        # networkmanagerapplet
        # dex
      ];
    };
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };

  # Screen locker PAM services
  security.pam.services = {
    i3lock-color.enable = true;
    sddm.kwallet.enable = true;
  };
}
