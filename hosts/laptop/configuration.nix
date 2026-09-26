# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

# TODO:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./modules/polkit-rules.nix
    ./modules/users.nix
    ../../modules/nixos/users

    # === CORE ===
    ../../modules/nixos/core/boot.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/fonts.nix
    ../../modules/nixos/core/network.nix
    ../../modules/nixos/core/nixsetting.nix

    # === HARDWARE ===
    ../../modules/nixos/hardware/audio.nix

    # === DESKTOP ===
    ../../modules/nixos/desktop/xserver.nix

    # === WINDOW MANAGERS ===
    ../../modules/nixos/window-managers/i3.nix
    # ../../modules/nixos/window-managers/niri.nix

    # === SERVICES ===
    ../../modules/nixos/services/touchpad.nix
    ../../modules/nixos/services/printing.nix

    # === PROGRAMS ===
    ../../modules/nixos/programs/fish.nix

    # === MAINTENANCE ===
    ../../modules/nixos/maintenance/autoupdate.nix
  ];

  networking.hostName = "roxy"; # Define your hostname.

  services.displayManager.sddm.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4096;
    }
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 60;
    "vm.vfs_cache_pressure" = 50;
  };

  nix.settings = {
    max-jobs = 1;
    cores = 2;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    xdg-utils
    neovim
    tmux

    scrot
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
