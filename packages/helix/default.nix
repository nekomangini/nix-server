{ pkgs, ... }:

let
  helixFindword = pkgs.writeShellApplication {
    name = "hw";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
      helix
      ripgrep
      bat
    ];

    text = ''
      exec raku ${./helix-findword.raku} "$@"
    '';
  };

  helixFindFile = pkgs.writeShellApplication {
    name = "hf";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
      helix
      bat
    ];

    text = ''
      exec raku ${./helix-fzf.raku}
    '';
  };
in

{
  home.packages = [
    helixFindword
    helixFindFile
  ];
}
