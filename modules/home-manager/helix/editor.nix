{ ... }:

{
  programs.helix.settings = {
    theme = "rose_pine";

    editor = {
      line-number = "relative";
      bufferline = "multiple";
      end-of-line-diagnostics = "hint";

      cursor-shape = {
        insert = "bar";
        normal = "underline";
        select = "underline";
      };

      lsp.display-inlay-hints = true;
    };

    keys = {
      insert.j.k = "normal_mode";

      normal = {
        "A-g" = [
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
        ];

        "C-y" = [
          ":sh rm -f /tmp/unique-file"
          ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
          ''
            :insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty
          ''
          ":open %sh{cat /tmp/unique-file}"
          ":redraw"
        ];

        "space" = {
          F = "no_op";
          q = ":quit";
        };

        space.f = {
          F = "file_picker_in_current_directory";
          b = "file_picker_in_current_buffer_directory";
          f = "file_picker";
          o = ":open ~/.config/helix/config.toml";
          s = ":write";
        };
      };
    };
  };
}
