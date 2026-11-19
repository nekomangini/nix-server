{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    vimgolf
  ];
}
