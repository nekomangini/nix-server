{ ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "noctalia";
    };
  };

  xdg.configFile."zellij/layouts/dev.kdl".source = ./dev.kdl;
  xdg.configFile."zellij/layouts/dots.kdl".source = ./dots.kdl;
}
