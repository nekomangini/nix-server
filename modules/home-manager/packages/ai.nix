{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qwen-code
    opencode
    kilocode-cli
  ];
}
