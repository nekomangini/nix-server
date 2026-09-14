#!/usr/bin/env raku
use v6.d;

sub MAIN {
    loop {
        my @options = (
            'List sessions',
            'Run tmx-sessions',
            'Run tmx-rails',
            'Create tmux session',
            'Delete tmux session',
            'Attach to session',
            'Quit',
        );
        my $fzf = run <
            fzf
            --height=~50%
            --layout=reverse
            --prompt=Tmux-Manager:
        >, :in, :out;
        $fzf.in.say($_) for @options;
        $fzf.in.close;
        my $choice = $fzf.out.slurp.trim;

        given $choice {
            when 'List sessions' {
                list-sessions;
            }
            when 'Run tmx-sessions' {
                run 'tmx-sessions';
                last;
            }
            when 'Run tmx-rails' {
                run 'tmx-rails';
                last;
            }
            when 'Create tmux session' {
                create-session;
                last;
            }
            when 'Delete tmux session' {
                delete-session;
                last;
            }
            when 'Attach to session' {
                attach-session;
                last;
            }
            when 'Quit' {
                exit 0;
            }
            default {
                say 'Aborted.';
                last;
            }
        }
    }
}

sub attach-to($session) {
    if %*ENV<TMUX> {
        run 'tmux', 'switch-client', '-t', $session;
    } else {
        run 'tmux', 'attach-session', '-t', $session;
    }
}

sub create-session {
    print "Session name: ";
    my $name = $*IN.get.trim;
    return unless $name;
    run 'tmux', 'new-session', '-d', '-s', $name;
    attach-to($name);
}

sub list-sessions {
    my $tmux = run 'tmux', 'ls', :out, :err;
    my $output = $tmux.out.slurp(:close);

    if $tmux.exitcode != 0 || !$output.trim {
        say "No active tmux sessions.";
        return;
    }

    my $fzf = run <fzf --height=~50% --layout=reverse --prompt=Sessions:>, :in, :out;
    $fzf.in.print($output);
    $fzf.in.close;
    my $selected = $fzf.out.slurp.trim;
    return unless $selected;

    my $session = $selected.split(':')[0];
    attach-to($session);
}

sub delete-session {
    my $tmux = run 'tmux', 'ls', :out;
    my $fzf = run <fzf --height=~50% --layout=reverse --prompt=Kill-Session:>, :in, :out;
    $fzf.in.print($tmux.out.slurp);
    $fzf.in.close;
    my $selected = $fzf.out.slurp.trim;
    return unless $selected;
    my $session = $selected.split(':')[0];
    run 'tmux', 'kill-session', '-t', $session;
}

sub attach-session {
    my $tmux = run 'tmux', 'ls', :out;
    my $fzf = run <fzf --height=~50% --layout=reverse --prompt=Attach-Session:>, :in, :out;
    $fzf.in.print($tmux.out.slurp);
    $fzf.in.close;
    my $selected = $fzf.out.slurp.trim;
    return unless $selected;
    my $session = $selected.split(':')[0];
    attach-to($session);
}
