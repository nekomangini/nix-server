#!/usr/bin/env raku
use v6.d;

constant $REPO_PATH = '/mnt/D/dev/01-projects/nekopaper';
constant $DATE_TODAY = DateTime.now(formatter => { sprintf "%02d-%02d-%d", .month, .day, .year });
constant $COMMIT_MESSAGE = "update wallpaper $DATE_TODAY";

unless chdir($REPO_PATH) {
    note "❌ Error: Could not find repository at '$REPO_PATH'";
    exit 1;
}

# 1. Verify it's a Git repo
run('git', 'status', :out, :err) or die "❌ Not a Git repository!";

# 2. CHECK FOR UPDATES (Remote and Local)
say "🔍 Checking for updates...";
run 'git', 'fetch', :out, :err;

my $local        = run('git', 'rev-parse', 'HEAD', :out).out.slurp.trim;
my $remote       = run('git', 'rev-parse', '@{u}', :out).out.slurp.trim;
my $has_changes  = run('git', 'status', '--porcelain', :out).out.slurp.trim.chars > 0;
my $is_behind    = run('git', 'rev-list', '..@{u}', '--count', :out).out.slurp.trim.Int > 0;

# Exit early if absolutely nothing has changed anywhere
if !$has_changes && !$is_behind && $local eq $remote {
    say "✅ Everything is up to date. Exiting.";
    exit 0;
}

# Only pull if the remote has moved ahead of us
if $is_behind {
    say "📥 Remote changes detected. Pulling...";
    run('git', 'pull') or die "❌ Git pull failed!";
}

if $has_changes {
    say "📝 Local changes detected. Proceeding...";
}

# 3. Run Python logic
# Only runs if not exit early
say "⚙️  Running metadata generator...";
run('python', 'make_json.py') or die "❌ Python script failed!";

# 4. Move JSON
if 'wallpapers.json'.IO.e {
    'wallpapers.json'.IO.rename('./public/wallpapers.json');
    say "🚚 JSON moved to ./public";
} else {
    note "⚠️  wallpapers.json not found!";
}

# 5. Git Add with Lock Handling
my $add-proc = run 'git', 'add', '.';
if $add-proc.exitcode != 0 && '.git/index.lock'.IO.e {
    say "🔓 Removing stale lock file...";
    unlink '.git/index.lock';
    $add-proc = run 'git', 'add', '.';
}

$add-proc or die "❌ Git add failed definitively.";

# 6. Handle Commit & Push
# my $commit = run 'git', 'commit', '-m', "test: Validate Raku automation script";
my $commit = run 'git', 'commit', '-m', "chore: $COMMIT_MESSAGE";

given $commit.exitcode {
    when 0 {
        say "✨ SUCCESS: Changes committed.";
        if run('git', 'push') {
            say "🚀 SUCCESS: Changes pushed to remote.";
        } else {
            note "❌ ERROR: Git push failed.";
            exit 1;
        }
    }
    when 1 {
        say "ℹ️  INFO: No changes to commit (Working tree clean).";
    }
    default {
        note "❌ ERROR: Git commit failed (Code: {$commit.exitcode})";
        exit 1;
    }
}
