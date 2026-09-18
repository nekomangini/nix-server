#!/usr/bin/env raku
use v6.d;

constant %PATHS = (
    notes    => "/mnt/D/notes",
    raku     => "/mnt/D/dev/02-areas/scripts",
    dotfiles => "/home/nekomangini/nix-server",
    blog     => "/mnt/D/notes/01-para/02-areas/media/blogs"
);

sub MAIN(Str $session?) {
    my @sessions = %PATHS.keys.sort;

    my $selected = $session // do {
        my $proc = run 'fzf',
            '--prompt=Emacs session: ',
            '--style', 'full',
            '--preview',
            'set q {}
            switch $q
                case notes
                    echo "Notes workspace

                Opens Doom Emacs (terminal)
                Directory: ~/sync/notes
                Buffer: Dired"

                case raku
                    echo "Raku workspace

                Opens Doom Emacs (terminal)
                Directory: ~/Programming/scripts
                Buffer: Dired"

                case dotfiles
                    echo "Dotfiles workspace

                Opens Doom Emacs (terminal)
                Directory: ~/nix-server
                Buffer: Dired"

                case blog
                    echo "Blog workspace

                Opens Doom Emacs (terminal)
                Directory: ~/sync/notes/01-para/02-areas/media/blogs
                Buffer: Dired"

                case quit
                    echo "Exit without opening Doom Emacs"
            end',
            '--height=~50%',
            '--layout=reverse',
            :in,
            :out;

        # Display all sessions followed by Quit
        for |@sessions, 'quit' -> $option {
            $proc.in.say($option);
        }

        $proc.in.close;
        $proc.out.slurp(:close).trim;
    };

    # User pressed Esc or selected Quit
    exit 0 unless $selected;
    exit 0 if $selected eq 'quit';

    unless %PATHS{$selected}:exists {
        note "Unknown session: '$selected'. Valid: { @sessions.join(', ') }";
        exit 1;
    }

    my $path = %PATHS{$selected};

    unless $path.IO.e {
        note "Path not found: '$path'";
        exit 1;
    }

    run 'kitten', '@', 'set-tab-title', "doom-$selected";
    run 'emacsclient', '-nw', '-a', '', $path;
}
