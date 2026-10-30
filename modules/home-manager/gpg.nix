{ pkgs, ... }:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    # if the build says this option doesn't exist, use: pinentry.package = pkgs.pinentry-curses;
    pinentry.package = pkgs.pinentry-curses;
  };
}
