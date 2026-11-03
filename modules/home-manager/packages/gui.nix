{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    libreoffice
    zathura
    planify
    obsidian
    joplin-desktop
    # brave
    (pkgs.brave.override { commandLineArgs = "--password-store=kwallet6"; })
    # vivaldi
    (pkgs.vivaldi.override { commandLineArgs = "--password-store=kwallet6"; })
  ];
}
