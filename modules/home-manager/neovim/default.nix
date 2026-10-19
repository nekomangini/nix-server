{ pkgs, ... }:

{
  imports = [
    ./neovide.nix
    ./astronvim.nix
  ];

  home.packages = with pkgs; [
    neovide
  ];
}
