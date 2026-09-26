{ pkgs, ... }:

# TODO:
let
  nekoEmacs = pkgs.emacs-gtk.pkgs.withPackages (epkgs: [
    epkgs.treesit-grammars.with-all-grammars
  ]);

  doomc = pkgs.writeShellApplication {
    name = "doomc";
    runtimeInputs = with pkgs; [
      rakudo
      kitty
      fzf
      nekoEmacs
    ];
    text = ''
      exec raku ${./sessions.raku} "$@"
    '';
  };
in

{
  home.packages = [
    doomc
  ];
}
