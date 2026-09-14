{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          # Save and restore tmux sessions
          set -g @resurrect-capture-pane-contents 'on'
          # Restore these programs
          set -g @resurrect-processes 'ssh mosh hx nvim emacs'
          # Save session every directory
          set -g @resurrect-strategy-hx 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          # Auto-save session every 10 minutes
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      # Unbind default prefix key (C-b) and change to (C-\)
      unbind C-b
      set -g prefix 'C-\'

      # Panes
      bind | split-window -h
      bind - split-window -v

      # Sessions
      bind N new-session -c "#{pane_current_path}"
      bind c new-window  -c "#{pane_current_path}"

      # --- Color Fixes ---
      # Enable true color support
      set -g default-terminal "tmux-256color"

      # Enable true color (24-bit) support
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -ga terminal-overrides ",xterm-kitty:Tc"

      # Show continuum status in tmux status bar
      set -g status-right 'Continuum: #{continuum_status}'
    '';
  };
}
