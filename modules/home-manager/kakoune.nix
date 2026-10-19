{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;

    plugins = with pkgs.kakounePlugins; [
      kakoune-lsp
    ];

    extraConfig = ''
      colorscheme plain

      add-highlighter global/ number-lines -relative -hlcursor
      set-option global ui_options assistant=none

      set-option global indentwidth 2
      set-option global tabstop 2

      # jk to ESC in insert mode
      hook global InsertChar k %{
        try %{
          exec -draft hH <a-k>jk<ret> d
          exec <esc>
        }
      }
    '';
  };
}
