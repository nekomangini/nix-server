#!/usr/bin/env raku
use v6.d;

sub MAIN {
    my $selected-file =
        run(
            'fzf',
            '--delimiter', ':',
            '--preview', 'bat --color=always {}',
            '--preview-window', 'up,60%,border-bottom',
            :out
        ).out.slurp(:close).trim;

    if $selected-file {
        run 'hx', $selected-file;
    }
}
