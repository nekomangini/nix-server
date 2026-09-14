{ pkgs, ... }:

let
  helix = pkgs.helix;
  kitty = pkgs.kitty;
  tmux = pkgs.tmux;
  foot = pkgs.foot;
  zellij = pkgs.zellij;

  # emacs = pkgs.emacs-gtk;
  emacs = pkgs.emacs-pgtk.pkgs.withPackages (epkgs: [
    epkgs.treesit-grammars.with-all-grammars
  ]);

  kittySession = pkgs.writeText "kitty-session.conf" ''
    new_tab main
    launch ${tmux}/bin/tmux new-session -A -s main

    new_tab ssh
    launch ${tmux}/bin/tmux new-session -A -s ssh

    new_tab zellij-logs
    launch ${zellij}/bin/zellij attach --create logs

    new_tab zellij-work
    launch ${zellij}/bin/zellij attach --create work

    new_tab tmux-dotfiles
    launch ${tmux}/bin/tmux new-session -A -s dotfiles
  '';
in

# TODO
# Simplify/Move to scripts/default.nix if possible
{
  home.packages = with pkgs; [
    # ===== Emacs =====
    (writeShellScriptBin "nkt" ''
      exec ${emacs}/bin/emacsclient -nw -a "" "$@"
    '')

    (writeShellScriptBin "doom-terminal" ''
      exec ${kitty}/bin/kitty --hold ${emacs}/bin/emacsclient -nw -a ""
    '')

    # ===== Wayland =====
    # TEST
    # (writeShellScriptBin "hed" ''
    #   exec ${emacs-pgtk}/bin/emacsclient -nw
    # '')

    # NOTE: Used in wayland session
    (writeShellScriptBin "doom-foot-terminal" ''
      if ! ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a "" 2>/dev/null; then
        ${foot}/bin/foot --server &
        sleep 0.3
        exec ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a ""
      fi
    '')

    # ===== Terminal =====
    # kitty
    (writeShellScriptBin "dev-workspace" ''
      exec ${kitty}/bin/kitty --session ${kittySession}
    '')

    # ===== Scripts=====
    # Joplin
    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    # ===== AUTOMATION =====
  ];
}
