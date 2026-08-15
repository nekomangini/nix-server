{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils
    unrar
    nmap
    fd
    ripgrep
    fzf
    zoxide
    eza
    fastfetch
    htop
    bat
    highlight
    delta
    xclip
    wl-clipboard
    jq
    poppler
    resvg
    unzip
    woeusb
    lm_sensors
    xdotool
    appimage-run
  ];
}
