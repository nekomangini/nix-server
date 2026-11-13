{ pkgs, config, ... }:

let
  yaml = pkgs.formats.yaml { };

  lazygitBase = yaml.generate "lazygit-base.yml" {
    os = {
      edit = "${pkgs.helix}/bin/hx {{filename}}";
      editAtLine = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
      editAtLineAndWait = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
      editInTerminal = true;
      openDirInEditor = "${pkgs.helix}/bin/hx {{dir}}";
    };
    gui = {
      showFileTree = true;
      showListFooter = true;
      showRandomTip = false;
      nerdFontsVersion = "3";
    };
    refresher = {
      refreshInterval = 10;
      fetchInterval = 60;
    };
  };

  # lazygit wrapped so it always loads: Nix settings first, Noctalia theme second
  lazygitWrapped = pkgs.symlinkJoin {
    name = "lazygit-wrapped";
    paths = [ pkgs.lazygit ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/lazygit \
        --set LG_CONFIG_FILE "${lazygitBase},${config.xdg.configHome}/lazygit/themes/noctalia.yml"
    '';
  };
in

{
  programs.git = {
    enable = true;

    settings = {
      core.editor = "${pkgs.helix}/bin/hx";
    };
  };

  programs.lazygit = {
    enable = true;
    package = lazygitWrapped;

    # settings = {
    #   os = {
    #     edit = "${pkgs.helix}/bin/hx {{filename}}";
    #     editAtLine = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
    #     editAtLineAndWait = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
    #     editInTerminal = true;
    #     openDirInEditor = "${pkgs.helix}/bin/hx {{dir}}";
    #   };

    #   gui = {
    #     showFileTree = true;
    #     showListFooter = true;
    #     showRandomTip = false;
    #     nerdFontsVersion = "3";
    #   };

    #   refresher = {
    #     refreshInterval = 10;
    #     fetchInterval = 60;
    #   };
    # };
  };
}
