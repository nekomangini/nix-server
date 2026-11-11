{ pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./theme.nix
  ];

  programs.alacritty = {
    enable = true;

    settings.terminal.shell = {
      program = "${pkgs.zellij}/bin/zellij";

    };
  };
}
