#!/usr/bin/env raku
use v6.d;

constant %SCRIPTS =
    notes      => 'sync-notes',
    nekopaper  => 'sync-nekopaper',
    blog       => 'sync-blog';

sub MAIN(Str $choice?) {

    my $selected = $choice // choose-script();

    # User pressed Esc or selected "quit"
    exit 0 unless $selected;
    exit 0 if $selected eq 'quit';

    unless %SCRIPTS{$selected}:exists {
        note "Unknown option: $selected";
        exit 1;
    }

    say "Running {%SCRIPTS{$selected}}...";

    run %SCRIPTS{$selected};
}

sub choose-script {

    my $proc = run 'fzf',
        '--prompt=Sync Repo: ',
        '--style', 'full',
        '--preview',
        'set q {}
        switch $q
            case notes
                echo "Runs: sync-notes"
            case nekopaper
                echo "Runs: sync-nekopaper"
            case blog
                echo "Runs: sync-blog"
            case quit
                echo "Exit without running anything."
        end',
        '--height=~50%',
        '--layout=reverse',
        :in,
        :out;

    # Display all scripts plus the Quit option
    for |%SCRIPTS.keys.sort, 'quit' -> $option {
        $proc.in.say($option);
    }

    $proc.in.close;

    $proc.out.slurp(:close).trim;
}
