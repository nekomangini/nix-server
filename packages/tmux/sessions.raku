#!/usr/bin/env raku
use v6.d;

constant %PATHS = (
    DOTFILES_PATH => '/home/nekomangini/nix-server',
    NOTES_PATH    => '/mnt/D/homelab/sync/notes',
    FLUTTER_PATH  => '/mnt/D/Programming/Projects/android-projects',
    VUE_PATH      => '/mnt/D/Programming/Projects/project-vue',
    RUBY_PATH     => '/mnt/D/Programming/Projects/project-rubyonrails',
);

sub MAIN(Str $choice?) {
    my @sessions = <vue flutter notes dotfiles ruby main>;

    my $selected = $choice // do {
        my $proc = run 'fzf',
                       '--prompt=Tmux session: ',
                       '--height=~50%',
                       '--layout=reverse',
                       :in, :out;

        # Display all sessions + quit
        for |@sessions, 'quit' -> $option {
                $proc.in.say($option);
            }

        # $proc.in.say: @sessions.join("\n");
        $proc.in.close;
        $proc.out.slurp(:close).trim;
    };

    exit 0 unless $selected;
    exit 0 if $selected eq 'quit';

    unless $selected ∈ @sessions {
        note "❌ '$selected' is not a predefined session.";
        exit 1;
    }

    my $check = run 'tmux', 'has-session', '-t', $selected, :out, :err;
    create-session($selected) if $check.exitcode != 0;

    if %*ENV<TMUX> {
        shell 'tmux switch-client -t ' ~ $selected;
    } else {
        shell 'tmux attach-session -t ' ~ $selected;
    }
}

sub create-session(Str $name) {
    my $path = do given $name {
        when 'flutter'  { %PATHS<FLUTTER_PATH>  }
        when 'vue'      { %PATHS<VUE_PATH>      }
        when 'notes'    { %PATHS<NOTES_PATH>    }
        when 'dotfiles' { %PATHS<DOTFILES_PATH> }
        when 'ruby'     { %PATHS<RUBY_PATH>     }
        when 'main'     { $*HOME.Str            }
        default         { $*HOME.Str            }
    } // $*HOME.Str;

    unless $path.IO.e && $path.IO.d {
        note "📂 Path not found: '$path'. Falling back to \$HOME.";
        $path = $*HOME.Str;
    }

    say "🚀 Creating '$name' in: $path";
    run 'tmux', 'new-session', '-d', '-s', $name, '-c', $path;
    sleep 0.1;

    given $name {
        when 'vue' {
            run 'tmux', 'rename-window', '-t', "{$name}:0", 'explorer';
            run 'tmux', 'send-keys', '-t', "{$name}:0", 'y', 'C-m';
            run 'kitten', '@', 'set-tab-title', 'tmux-vue';
        }
        when 'flutter' {
            run 'tmux', 'rename-window', '-t', "{$name}:0", 'explorer';
            run 'tmux', 'send-keys', '-t', $name, 'y', 'C-m';
            run 'kitten', '@', 'set-tab-title', 'tmux-flutter';
        }
        when 'dotfiles' {
            run 'tmux', 'rename-window', '-t', "{$name}:0", 'editor';
            run 'tmux', 'send-keys', '-t', "{$name}:0", 'hx', 'C-m';
            run 'tmux', 'new-window', '-t', $name, '-n', 'console', '-c', $path;
            run 'tmux', 'select-window', '-t', "{$name}:editor";
            run 'kitten', '@', 'set-tab-title', 'tmux-dotfiles';
        }
        when 'notes' {
            run 'tmux', 'rename-window', '-t', "{$name}:0", 'editor';
            run 'tmux', 'send-keys', '-t', "{$name}:0", 'emacsclient -nw -a "" "' ~ $path ~ '"', 'C-m';
            run 'kitten', '@', 'set-tab-title', 'tmux-notes';
        }
        when 'ruby' {
            run 'tmux', 'rename-window', '-t', "{$name}:0", 'editor';
            run 'tmux', 'send-keys', '-t', "{$name}:0", 'hx', 'C-m';
            run 'tmux', 'new-window', '-t', $name, '-n', 'server', '-c', $path;
            run 'tmux', 'new-window', '-t', $name, '-n', 'console', '-c', $path;
            run 'tmux', 'select-window', '-t', "{$name}:server";
            run 'kitten', '@', 'set-tab-title', 'tmux-ruby';
        }
        default {
            run 'tmux', 'send-keys', '-t', $name, 'y', 'C-m';
            run 'kitten', '@', 'set-tab-title', 'tmux-main';
        }
    }
}
