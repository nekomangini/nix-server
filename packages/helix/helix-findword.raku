#!/usr/bin/env raku
use v6.d;

sub MAIN(Str $word) {
    # rg --vimgrep <word> | fzf --preview 'cat {}' --height 70% | xargs hx
    # rg --vimgrep <word> | fzf --height 70% | xargs hx

    # NOTE: Add a preview 
    # --preview 'bat --color=always {}' --preview-window '~3'
    my $proc1 = run 'rg', '--vimgrep', $word, :out;
    my $proc2 = run 'fzf',
        '--delimiter', ':',
        '--preview', 'bat --color=always --highlight-line {2} {1}',
        '--preview-window', 'up,60%,border-bottom',
        :in($proc1.out), :out, :err;
    $proc1.out.slurp;
    my $selected-line = $proc2.out.slurp(:close).trim;
    my $exitcode = $proc2.exitcode;

    if $exitcode != 0 {
        warn "Fzf selection cancelled or failed (Exit Code: $exitcode):\n{$proc2.err.slurp}";
        exit 1;
    }

    if $selected-line.chars {
        my @parts = $selected-line.split(":", 4);
        my $hx-args = @parts[0..2].join(":");

        say "Launching hx with clean arguments: $hx-args";

        shell "exec hx $hx-args";

        say "Editor closed.";
    } else {
        say "No selection made. Exiting.";
    }
}
