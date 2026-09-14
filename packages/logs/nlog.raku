#!/usr/bin/env raku
use v6.d;

# ──────────────────────────────────────────────
# DIRECTORY
# ──────────────────────────────────────────────

my $JOURNAL_DIR_PATH = "/mnt/D/homelab/sync/notes/02-journal";
my $BLOG_DIR_PATH    = "/mnt/D/homelab/sync/notes/01-para/02-areas/media/blogs";

# ──────────────────────────────────────────────
# CONSTANTS
# ──────────────────────────────────────────────

constant $DEFAULT_EXT = '.org';
constant $DATE = DateTime.now.Date.Str;

# ──────────────────────────────────────────────
# DAILY LOG
# ──────────────────────────────────────────────

constant $DAILY_TEMPLATE = qq:to/END/;
* 🎯 TODAY'S TASK:
** Primary task:
*** 

** Other tasks:
***
***

* 🚧 TROUBLESHOOTING
** Problem Encountered:
*** 
** Hypothesized Cause (Patterns):
*** 
** Resolution (What fixed it?):
*** 
** Code/Commands:
#+BEGIN_SRC shell
#+END_SRC

* 🧠 LEARNINGS & TOOLS NOTES
** What I learned:
***
** Code/Commands:
#+BEGIN_SRC shell
#+END_SRC

** Where to document (wiki/blog):

* 📝 UNSTRUCTURED NOTES
*** 

* 💾 END-OF-DAY SAVE POINT
** What I was doing:
** What to do first tomorrow:
END

# ──────────────────────────────────────────────
# WEEKLY LOG
# ──────────────────────────────────────────────

constant $WEEKLY_TEMPLATE = qq:to/END/;
* 📊 WEEKLY SNAPSHOT
* 🏆 ACHIEVEMENTS
* 🧠 KEY LEARNINGS
* 🧭 NEXT WEEK'S FOCUS
** Primary goal:
** Skills to level up:
** One thing to do differently:
END

# ──────────────────────────────────────────────
# MONTHLY LOG
# ──────────────────────────────────────────────

constant $MONTHLY_TEMPLATE = qq:to/END/;
* 📊 ACHIEVEMENTS
** 

* 🛠️ TECH STACK EVOLUTION
** What tools did I master this month?
** What should be added to the Blog?
END

# ──────────────────────────────────────────────
# QUICK CAPTURE LOG
# ──────────────────────────────────────────────

constant $QCAP-TEMPLATE = qq:to/END/;
date: $DATE
* 🎯 Task in Focus
** What I’m doing:
**
** Why I’m doing it:
**

* 🔥 Problem
** What’s broken or missing:
**

* 💡 Solution
** My approach:
**
** Code / Commands:

#+BEGIN_SRC shell
#+END_SRC

* 📚 Resources:
**

* 🧠 Key Insight
** What I learned:
**

* 💾 Next Steps
**
END

# ──────────────────────────────────────────────
# JOURNAL PATH/FILENAME HELPERS
# ──────────────────────────────────────────────

sub journal-dir(Str $type) {
    my $year = DateTime.now.year.Str;
    my $dir = "$JOURNAL_DIR_PATH/$type/$year";
    mkdir($dir) unless $dir.IO.d;
    return $dir;
}

sub journal-filename(Str $type) {
    given $type {
        when 'daily' {
            return $DATE ~ $DEFAULT_EXT;
        }
        when 'weekly' {
            my ($iso-year, $iso-week) = Date.today.week;
            return sprintf("%d-W%02d", $iso-year, $iso-week) ~ $DEFAULT_EXT;
        }
        when 'monthly' {
            my $now = DateTime.now;
            return sprintf("%d-%02d", $now.year, $now.month) ~ $DEFAULT_EXT;
        }
    }
}

# ──────────────────────────────────────────────
# EXTRACTION HELPERS
# ──────────────────────────────────────────────

# Return each sub-heading under $heading as a separate item. Non-heading
# lines (wrapped text, code block contents) are glued onto whichever item
# most recently started.
sub section-items(Str $text, Str $heading --> Array) {
    my @lines = $text.lines;
    my $start;
    my $level;

    for @lines.kv -> $i, $line {
        if $line ~~ /^ (\*+) \h+ (.*) $/ {
            my $lvl   = $0.chars;
            my $htext = $1.Str.trim.subst(/':' \h* $/, '');
            if $htext.lc.contains($heading.lc) {
                $level = $lvl;
                $start = $i + 1;
                last;
            }
        }
    }
    return () unless $start.defined;

    my @items;
    my $buffer = '';
    for $start ..^ @lines.elems -> $i {
        my $line = @lines[$i];
        last if $line ~~ /^ (\*+) \h+ / && $0.chars <= $level;

        if $line ~~ /^ (\*+) \h* (.*) $/ {
            @items.push($buffer.trim) if $buffer.trim ne '';
            $buffer = $1.Str.trim;
        }
        else {
            $buffer ~= ($buffer eq '' ?? '' !! "\n") ~ $line;
        }
    }
    @items.push($buffer.trim) if $buffer.trim ne '';
    return @items;
}

# Like section-items, but reaches into ALL nesting under $heading (not
# just one level) and returns only the "leaf" headings — ones with no
# deeper heading immediately following them. This is what lets it pick up
# both hand-typed single-level entries (e.g. '** Testing achievements')
# and sync-generated nested ones ('** 2026-07-20:' -> '*** item') the same
# way, without caring which depth the real content landed at.
sub leaf-items(Str $text, Str $heading --> Array) {
    my @lines = $text.lines;
    my $start;
    my $level;

    for @lines.kv -> $i, $line {
        if $line ~~ /^ (\*+) \h+ (.*) $/ {
            my $lvl   = $0.chars;
            my $htext = $1.Str.trim.subst(/':' \h* $/, '');
            if $htext.lc.contains($heading.lc) {
                $level = $lvl;
                $start = $i + 1;
                last;
            }
        }
    }
    return () unless $start.defined;

    my $end = @lines.elems;
    for $start ..^ @lines.elems -> $i {
        if @lines[$i] ~~ /^ (\*+) \h+ / && $0.chars <= $level {
            $end = $i;
            last;
        }
    }

    my @items;
    for $start ..^ $end -> $i {
        my $line = @lines[$i];
        next unless $line ~~ /^ (\*+) \h* (.*) $/;
        my $lvl     = $0.chars;
        my $content = $1.Str.trim;
        next if $content eq '';

        my $is-leaf = True;
        if $i + 1 < $end && @lines[$i + 1] ~~ /^ (\*+) \h* / && $0.chars > $lvl {
            $is-leaf = False;
        }
        @items.push($content) if $is-leaf;
    }
    return @items;
}

sub ensure-log(Str $type, Str $template --> IO::Path) {
    my $dir  = journal-dir($type);
    my $path = "$dir/{journal-filename($type)}".IO;
    spurt($path, $template) unless $path.e;
    return $path;
}

# Insert a new dated heading (today's date, or $tag if given) one level
# below $heading, with @items as its children one level below that.
#
# Trailing blank lines at the end of the section (spacing before the next
# heading) are preserved rather than swallowed. If, once those trailing
# blanks are set aside, the section contains nothing but a single blank
# placeholder heading (the template's bare '** '), that placeholder is
# replaced rather than left dangling next to the new entry.
sub append-dated-section(Str $text, Str $heading, @items, Str $tag = DateTime.now.Date.Str --> Str) {
    return $text unless @items;

    my @lines = $text.lines;
    my $start;
    my $level;

    for @lines.kv -> $i, $line {
        if $line ~~ /^ (\*+) \h+ (.*) $/ {
            my $lvl   = $0.chars;
            my $htext = $1.Str.trim.subst(/':' \h* $/, '');
            if $htext.lc.contains($heading.lc) {
                $level = $lvl;
                $start = $i + 1;
                last;
            }
        }
    }

    unless $start.defined {
        note "Heading '$heading' not found — skipping insert.";
        return $text;
    }

    my $raw-end = @lines.elems;
    for $start ..^ @lines.elems -> $i {
        if @lines[$i] ~~ /^ (\*+) \h+ / && $0.chars <= $level {
            $raw-end = $i;
            last;
        }
    }

    # keep trailing blank lines as the spacer before the next heading
    my $content-end = $raw-end;
    while $content-end > $start && @lines[$content-end - 1].trim eq '' {
        $content-end--;
    }

    my @section = @lines[$start ..^ $content-end];
    if @section.elems == 1 && @section[0] ~~ /^ (\*+) \h* $/ && $0.chars == $level + 1 {
        $content-end = $start;
    }

    my @block = ('*' x ($level + 1)) ~ " $tag:";
    for @items -> $item {
        @block.push(('*' x ($level + 2)) ~ " $item");
    }

    @lines.splice($content-end, 0, @block);
    return @lines.join("\n") ~ "\n";
}

# ──────────────────────────────────────────────
# FILE PICKERS (for backfilling non-current logs)
# ──────────────────────────────────────────────

sub pick-journal-file(Str $type --> IO::Path) {
    my $base = "$JOURNAL_DIR_PATH/$type".IO;

    unless $base.e {
        say "No $type directory found at $base";
        exit;
    }

    my @files = $base.dir.grep(*.d).map({ .dir.grep(*.f) }).flat.sort(*.Str).reverse;

    if @files.elems == 0 {
        say "No $type files found under $base";
        exit;
    }

    my $fzf = run <fzf --height=~50% --layout=reverse --prompt=Select-File:>, :in, :out;
    $fzf.in.say($_.relative($base)) for @files;
    $fzf.in.close;
    my $choice = $fzf.out.slurp.trim;

    if $choice eq '' {
        say "Aborted.";
        exit;
    }

    return "$base/$choice".IO;
}

# ──────────────────────────────────────────────
# DAILY -> WEEKLY
# ──────────────────────────────────────────────

sub extract-daily-to-weekly(IO::Path $daily-file = "{journal-dir('daily')}/{journal-filename('daily')}".IO) {
    unless $daily-file.e {
        say "Daily file not found: $daily-file";
        exit;
    }

    my $daily-text = $daily-file.slurp;
    my $date-tag = $daily-file.basename.subst(/\.org$/, '');
    my @tasks   = section-items($daily-text, 'Primary task');
    my @learned = section-items($daily-text, 'What I learned');

    if !@tasks && !@learned {
        say "Nothing filled in on $daily-file — skipping.";
        return;
    }

    my $weekly-path = ensure-log('weekly', $WEEKLY_TEMPLATE);
    my $weekly-text = $weekly-path.slurp;

    $weekly-text = append-dated-section($weekly-text, 'weekly snapshot', @tasks, $date-tag)
        if @tasks;
    $weekly-text = append-dated-section($weekly-text, 'Key Learnings', @learned, $date-tag)
        if @learned;

    spurt($weekly-path, $weekly-text);
    say "Synced $daily-file -> $weekly-path";
}

# ──────────────────────────────────────────────
# WEEKLY -> MONTHLY
# ──────────────────────────────────────────────

sub extract-weekly-to-monthly(IO::Path $weekly-file = "{journal-dir('weekly')}/{journal-filename('weekly')}".IO) {
    unless $weekly-file.e {
        say "Weekly file not found: $weekly-file";
        exit;
    }

    my $weekly-text  = $weekly-file.slurp;
    my @achievements = leaf-items($weekly-text, 'ACHIEVEMENTS');
    my @progress     = leaf-items($weekly-text, 'weekly snapshot');
    my @learnings    = leaf-items($weekly-text, 'Key Learnings');

    if !@achievements && !@progress && !@learnings {
        say "Nothing filled in on $weekly-file — skipping.";
        return;
    }

    my $monthly-path = ensure-log('monthly', $MONTHLY_TEMPLATE);
    my $monthly-text = $monthly-path.slurp;
    my ($iso-year, $iso-week) = Date.today.week;
    my $week-tag = sprintf("%d-W%02d", $iso-year, $iso-week);

    $monthly-text = append-dated-section($monthly-text, 'ACHIEVEMENTS', @achievements, $week-tag)
        if @achievements;

    my @tech;
    @tech.push("Progress: $_") for @progress;
    @tech.push("Learned: $_")  for @learnings;
    $monthly-text = append-dated-section($monthly-text, 'What tools did I master this month?', @tech, $week-tag)
        if @tech;

    spurt($monthly-path, $monthly-text);
    say "Synced $weekly-file -> $monthly-path";
}

# ──────────────────────────────────────────────
# FUNCTIONS
# ──────────────────────────────────────────────

sub create-qfile() {
    my $prompt-filename = prompt("Enter filename: ");
    my $prompt-category = prompt("Enter category: ");
    my $raw-filename = $prompt-filename.wordcase;
    my $category = $prompt-category.wordcase;

    my $dir = journal-dir('quick-capture');
    my $filename = "$category" ~ "___" ~ "$raw-filename";
    unless $filename.lc.ends-with($DEFAULT_EXT) {
        $filename ~= $DEFAULT_EXT;
    }
    my $full-path = "$dir/$filename";

    if $full-path.IO.e {
        say "File '$full-path' already exists. Aborting...";
        exit;
    }

    say "Creating file '$full-path' with template content...";
    sleep 1;

    spurt($full-path, $QCAP-TEMPLATE);
    say "Successfully created '$full-path'";
}

sub create-file($template-arg, Str $type) {
    my $dir = journal-dir($type);
    my $filename = journal-filename($type);
    my $full-path = "$dir/$filename";

    if $full-path.IO.e {
        say "File '$full-path' already exists. Aborting.";
        exit;
    }

    say "Creating file '$full-path' with template content...";
    sleep 1;

    spurt($full-path, $template-arg);

    say "Successfully created: '$full-path'";
}

sub create-blog() {
    my $prompt-blogname = prompt("Enter blogpost title: ");
    my $blog-filename = "blog-" ~ $prompt-blogname.trim.lc.subst(/\s+/, '-', :g);
    $blog-filename ~= $DEFAULT_EXT unless $blog-filename.ends-with($DEFAULT_EXT);

    chdir($BLOG_DIR_PATH);

    if $blog-filename.IO.e {
        say "File '$blog-filename' already exists. Aborting...";
        exit;
    }

    say "Creating file '$blog-filename'...";
    sleep 1;

    spurt($blog-filename, "");
    say "Successfully created '$blog-filename'";
}

sub create-log {
    my @options = (
        'Quick capture',
        'Daily log',
        'Blog draft',
        'Sync: Daily → Weekly (today)',
        'Sync: Daily → Weekly (pick file)',
        'Sync: Weekly → Monthly (this week)',
        'Sync: Weekly → Monthly (pick file)',
        'Quit'
    );

    my $fzf = run <fzf --style full --height=~50% --layout=reverse --prompt=Select-Template:>, :in, :out;
    $fzf.in.say($_) for @options;
    $fzf.in.close;
    my $choice = $fzf.out.slurp.trim;

    given $choice {
        when 'Quick capture' {
            create-qfile();
        }
        when 'Daily log' {
            create-file($DAILY_TEMPLATE, 'daily');
        }
        when 'Blog draft' {
            create-blog();
        }
        when 'Sync: Daily → Weekly (today)' {
            extract-daily-to-weekly();
        }
        when 'Sync: Daily → Weekly (pick file)' {
            extract-daily-to-weekly(pick-journal-file('daily'));
        }
        when 'Sync: Weekly → Monthly (this week)' {
            extract-weekly-to-monthly();
        }
        when 'Sync: Weekly → Monthly (pick file)' {
            extract-weekly-to-monthly(pick-journal-file('weekly'));
        }
        when 'Quit' {
            exit 0;
        }
        default {
            say "Aborted.";
        }
    }
}

# ──────────────────────────────────────────────
# ENTRY POINT
# ──────────────────────────────────────────────

if @*ARGS {
    given @*ARGS[0] {
        when 'sync-weekly'  { extract-daily-to-weekly()   }
        when 'sync-monthly' { extract-weekly-to-monthly() }
        default              { create-log() }
    }
} else {
    create-log();
}
