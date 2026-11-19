{ pkgs, config, ... }:

let
  helix = pkgs.helix;
  kitty = pkgs.kitty;
  tmux = pkgs.tmux;
  foot = pkgs.foot;
  htop = pkgs.htop;
  awww = pkgs.awww;
  fuzzel = pkgs.fuzzel;
  eza = pkgs.eza;
  emacs = config.programs.emacs.package;

  # ===== WALLPAPER =====
  wallDir = "${config.home.homeDirectory}/nix-server/wallpaper";

  wallpaperPicker =
    name: output: dir:
    pkgs.writeShellScriptBin name ''
      choice=$(
        while IFS= read -r file; do
          printf '%s\0icon\x1f%s/%s\n' "$file" "${dir}" "$file"
        done < <(${eza}/bin/eza -1 "${dir}") \
          | ${fuzzel}/bin/fuzzel --dmenu
      ) || exit 0
      [ -n "$choice" ] || exit 0

      exec ${awww}/bin/awww img --outputs ${output} "${dir}/$choice"
    '';

  wdvi = wallpaperPicker "wdvi" "DVI-D-1" wallDir;
  wdp = wallpaperPicker "wdp" "DP-1" wallDir;
  whdmi = wallpaperPicker "whdmi" "HDMI-A-1" "${wallDir}";

  # Ask which monitor, then run the matching picker
  nwall = pkgs.writeShellScriptBin "nwall" ''
    monitor=$(printf '%s\n' DVI-D-1 DP-1 HDMI-A-1 | ${fuzzel}/bin/fuzzel --dmenu -p "monitor: ") || exit 0

    case "$monitor" in
      DVI-D-1)  exec ${wdvi}/bin/wdvi ;;
      DP-1)     exec ${wdp}/bin/wdp ;;
      HDMI-A-1) exec ${whdmi}/bin/whdmi ;;
    esac
  '';

  # ===== Emacs Terminal =====
  nkt = pkgs.writeShellScriptBin "nkt" ''
    exec ${emacs}/bin/emacsclient -nw -a "" "$@"
  '';

  # ===== Wayland Emacs =====
  wm-focus = pkgs.writeShellScriptBin "wm-focus" ''
    # usage: wm-focus <app_id> <command...>  — focus the window if it exists, else run the command
    app="$1"; shift
    jq=${pkgs.jq}/bin/jq

    if [ -n "''${NIRI_SOCKET:-}" ]; then
      id=$(niri msg --json windows \
        | $jq -r --arg a "$app" '[.[] | select(.app_id == $a)][0].id // empty')
      [ -n "$id" ] && exec niri msg action focus-window --id "$id"
    elif [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
      addr=$(${pkgs.hyprland}/bin/hyprctl clients -j \
        | $jq -r --arg a "$app" '[.[] | select((.class | ascii_downcase) == ($a | ascii_downcase))][0].address // empty')
      [ -n "$addr" ] && exec ${pkgs.hyprland}/bin/hyprctl dispatch "hl.dsp.focus({ window = \"address:$addr\" })"
    fi
    exec "$@"
  '';

  emacs-gui-wayland = pkgs.writeShellScriptBin "emacs-gui-wayland" ''
    exec ${wm-focus}/bin/wm-focus emacs ${emacs}/bin/emacsclient -c -n -a ""
  '';

  emacs-dired-wayland = pkgs.writeShellScriptBin "emacs-dired-wayland" ''
    ${emacs-gui-wayland}/bin/emacs-gui-wayland
    exec ${emacs}/bin/emacsclient -n "''${1:-$PWD}"
  '';

  # ===== X11 Emacs (i3 and qtile) =====
  # Emacs focuses its own GUI frame (it sends _NET_ACTIVE_WINDOW), so no WM-specific
  # window lookup is needed. If there is no GUI frame (or no daemon), create one.
  emacs-gui-x11 = pkgs.writeShellScriptBin "emacs-gui-x11" ''
    ec=${emacs}/bin/emacsclient

    found=$($ec -e '(let ((f (seq-find
                              (lambda (fr)
                                (and (display-graphic-p fr)
                                     (not (equal (frame-parameter fr (quote name))
                                                 "emacs-run-launcher"))))
                              (frame-list))))
                      (when f
                        (select-frame-set-input-focus f)
                        "yes"))' 2>/dev/null)

    if [ "$found" != '"yes"' ]; then
      exec $ec -c -n -a ""
    fi
  '';

  emacs-dired = pkgs.writeShellScriptBin "emacs-dired" ''
    ${emacs-gui-x11}/bin/emacs-gui-x11
    exec ${emacs}/bin/emacsclient -n "''${1:-$PWD}"
  '';

  # ===== KITTY =====
  kittySession = pkgs.writeText "kitty-session.conf" ''
    new_tab docs
    launch ${tmux}/bin/tmux new-session -A -s main

    new_tab ssh
    launch ${tmux}/bin/tmux new-session -A -s ssh

    new_tab monitor
    launch ${htop}/bin/htop
  '';
in

# TODO
# Simplify/Move to scripts/default.nix if possible
{
  home.packages = with pkgs; [
    # ===== Emacs =====
    nkt
    emacs-gui-wayland
    emacs-gui-x11
    emacs-dired
    emacs-dired-wayland

    (writeShellScriptBin "doom-terminal" ''
      exec ${kitty}/bin/kitty --hold ${emacs}/bin/emacsclient -nw -a ""
    '')

    # ===== Wayland Terminal =====
    # NOTE: Used in wayland session
    # (writeShellScriptBin "doom-foot-terminal" ''
    #   if ! ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a "" 2>/dev/null; then
    #     ${foot}/bin/foot --server &
    #     sleep 0.3
    #     exec ${foot}/bin/footclient -- ${emacs}/bin/emacsclient -nw -a ""
    #   fi
    # '')

    (writeShellScriptBin "dev-workspace-wayland" ''
      exec ${wm-focus}/bin/wm-focus dev-workspace-wayland \
        ${kitty}/bin/kitty --class dev-workspace-wayland --session ${kittySession}
    '')

    # ===== X11 Terminal =====
    (writeShellScriptBin "dev-workspace" ''
      exec ${kitty}/bin/kitty --session ${kittySession}
    '')

    # ===== WALLPAPER=====
    wdvi
    wdp
    whdmi
    nwall

    # ===== Scripts=====
    # Joplin
    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    # ===== AUTOMATION =====
  ];
}
