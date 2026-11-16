{ pkgs, config, ... }:

{
  imports = [
    ./settings.nix
    # ./theme.nix
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      general.import = [ "${config.xdg.configHome}/alacritty/themes/noctalia.toml" ];

      terminal.shell = {
        # program = "${pkgs.zellij}/bin/zellij";
        program = "${pkgs.tmux}/bin/tmux";
        args = [
          "new-session"
          "-A"
          "-s"
          "main"
        ];
      };
    };
  };
}
