{ pkgs, config, ... }:

let
  zellij-docs = pkgs.writeShellScript "zellij-docs" ''
    exec ${pkgs.zellij}/bin/zellij attach --create docs
  '';
in
{
  imports = [
    ./settings.nix
    # ./theme.nix
  ];

  programs.foot = {
    enable = true;
    settings.main = {
      include = "${config.xdg.configHome}/foot/themes/noctalia";
      shell = "${zellij-docs}";
    };
  };
}
