# Qtile Configuration for NixOS - Dual Monitor Setup
# import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import (
    Click,
    Drag,
    Group,
    Key,
    Match,
    Screen,
    ScratchPad,
    DropDown,
)
from libqtile.lazy import lazy


mod = "mod4"
terminal = "kitty"
doom = "emacsclient -c"

# ──  Theme  ──────────────────
colors = {
    "bg": "#1a1b26",
    "fg": "#c0caf5",
    "accent": "#7aa2f7",
    "highlight": "#f7768e",
    "bg1": "#24283b",
    "bg2": "#414868",
    "gray": "#565f89",
    "red": "#f7768e",
    "green": "#73daca",
    "yellow": "#e0af68",
    "blue": "#7aa2f7",
    "purple": "#bb9af7",
    "aqua": "#b4f9f8",
}

# ── Keybindings  ──────────────────
keys = [
    # ── WINDOW MANAGEMENT  ──────────────────
    # NOTE: For tabbed setup (max layout) only
    Key([mod], "l", lazy.layout.next(), desc="Next window"),
    Key([mod], "h", lazy.layout.previous(), desc="Previous window"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "n", lazy.window.toggle_minimize(), desc="Toggle minimize (pseudo)"),
    # NOTE: Commented out because of tabbed setup(widget.TaskList)
    # Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    # Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    # Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    # Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Swap windows with Shift + hjkl
    # Key(
    #     [mod, "shift"],
    #     "h",
    #     lazy.layout.shuffle_left().when(layout=["monadtall", "monadwide"]),
    #     desc="Move window to the left",
    # ),
    # Key(
    #     [mod, "shift"],
    #     "l",
    #     lazy.layout.shuffle_right().when(layout=["monadtall", "monadwide"]),
    #     desc="Move window to the right",
    # ),
    # Key(
    #     [mod, "shift"],
    #     "j",
    #     lazy.layout.shuffle_down().when(
    #         layout=["monadtall", "verticaltile", "monadwide"]
    #     ),
    #     desc="Move window down",
    # ),
    # Key(
    #     [mod, "shift"],
    #     "k",
    #     lazy.layout.shuffle_up().when(
    #         layout=["monadtall", "verticaltile", "monadwide"]
    #     ),
    #     desc="Move window up",
    # ),
    # Resize with Control + hjkl
    # Key(
    #     [mod, "control"],
    #     "h",
    #     lazy.layout.grow_left(),
    #     lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
    #     desc="Grow window to the left",
    # ),
    # Key(
    #     [mod, "control"],
    #     "l",
    #     lazy.layout.grow_right(),
    #     lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
    #     desc="Grow window to the right",
    # ),
    # Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Key([mod], "v", lazy.window.toggle_floating(), desc="Toggle floating"),
    # Key([mod], "t", lazy.layout.toggle_split(), desc="Toggle split"),
    # Key([mod], "w", lazy.spawn("rofi -show window"), desc="Select window"),
    # ── LAUNCH APPLICATIONS  ──────────────────
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key([mod], "e", lazy.spawn(doom), desc="Launch Emacs"),
    Key(
        [mod],
        "s",
        lazy.group["scratchpad"].dropdown_toggle("emacs_scratchpad"),
        desc="Toggle Emacs scratchpad",
    ),
    # ── LAYOUT MANAGEMENT  ──────────────────
    # NOTE: Commented out because of tabbed setup(widget.TaskList)
    # Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    # Key([mod, "shift"], "space", lazy.prev_layout(), desc="Toggle between layouts"),
    # Key(
    #     [mod],
    #     "backslash",
    #     lazy.screen.toggle_group(),
    #     desc="Toggle to previous workspace",
    # ),
    # Key([mod], "Tab", lazy.screen.toggle_group(), desc="Toggle to previous workspace"),
    # ── WORKSPACE NAVIGATION  ──────────────────
    # Key(
    #     [mod],
    #     "o",
    #     lazy.screen.next_group(skip_empty=True),
    #     desc="Move to next workspace",
    # ),
    # Key(
    #     [mod],
    #     "i",
    #     lazy.screen.prev_group(skip_empty=True),
    #     desc="Move to previous workspace",
    # ),
    # ── QTILE SYSTEM  ──────────────────
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # ── MULTIMEDIA KEYS  ──────────────────
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
        desc="Volume up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
        desc="Volume down",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        desc="Mute",
    ),
    # Key([], "XF86AudioMicMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), desc="Mute mic"),
    # Brightness controls(LAPTOP)
    # Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl -e4 -n2 set 5%+"), desc="Brightness up"),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl -e4 -n2 set 5%-"), desc="Brightness down"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Previous track"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    Key([], "XF86AudioPause", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    # ── SCRIPTS  ──────────────────
    Key(
        [mod],
        "p",
        lazy.spawn("x-powermenu"),
        desc="Power menu",
    ),
    Key(
        [],
        "Print",
        lazy.spawn("x-screenshot DVI"),
        desc="Screenshot DVI monitor",
    ),
    Key(
        ["shift"],
        "Print",
        lazy.spawn("x-screenshot HDMI"),
        desc="Screenshot HDMI monitor",
    ),
    Key(
        ["mod1"],
        "Print",
        lazy.spawn("x-screenshot DP"),
        desc="Screenshot DP monitor",
    ),
    Key(
        ["control"],
        "Print",
        lazy.spawn("x-screenshot BOTH"),
        desc="Screenshot all monitors",
    ),
    Key(
        [mod],
        "b",
        lazy.spawn("x11-websearch"),
        desc="Search the Web",
    ),
    # ── MOUSE EMULATION  ──────────────────
    Key([mod, "control"], "h", lazy.spawn("xdotool mousemove_relative -- -20 0")),
    Key([mod, "control"], "j", lazy.spawn("xdotool mousemove_relative -- 0 20")),
    Key([mod, "control"], "k", lazy.spawn("xdotool mousemove_relative -- 0 -20")),
    Key([mod, "control"], "l", lazy.spawn("xdotool mousemove_relative -- 20 0")),
    # ── Diagonal movements  ──────────────────
    Key([mod, "control"], "u", lazy.spawn("xdotool mousemove_relative -- -40 -40")),
    Key([mod, "control"], "i", lazy.spawn("xdotool mousemove_relative -- 40 -40")),
    Key([mod, "control"], "n", lazy.spawn("xdotool mousemove_relative -- -40 40")),
    Key([mod, "control"], "m", lazy.spawn("xdotool mousemove_relative -- 40 40")),
    Key([mod, "control"], "comma", lazy.spawn("xdotool click 1")),
    Key([mod, "control"], "period", lazy.spawn("xdotool click 3")),
    # ── Scroll Wheel UP ──────────────────────────────────────────
    Key([mod, "control"], "y", lazy.spawn("xdotool click --clearmodifiers 4")),
    # ── Scroll Wheel DOWN ──────────────────────────────────────────
    Key([mod, "control"], "p", lazy.spawn("xdotool click --clearmodifiers 5")),
    # ── MULTI MONITOR SETUP + MONITOR NAVIGATION  ──────────────────
    Key([mod], "comma", lazy.to_screen(2), desc="Focus DP-1"),
    Key([mod], "period", lazy.to_screen(1), desc="Focus HDMI-0"),
    Key([mod], "slash", lazy.to_screen(0), desc="Focus DVI-D-0"),
    Key([mod, "shift"], "comma", lazy.window.toscreen(2), desc="Move to DP-1"),
    Key([mod, "shift"], "period", lazy.window.toscreen(1), desc="Move to HDMI-0"),
    Key([mod, "shift"], "slash", lazy.window.toscreen(0), desc="Move to DVI-D-0"),
]

# ── Layouts  ──────────────────
layouts = [
    layout.Max(margin=7),
    # layout.MonadTall(
    #     border_focus=colors["accent"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    #     margin=7,
    # ),
    # layout.VerticalTile(
    #     border_focus=colors["accent"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    #     margin=5,
    # ),
    # layout.MonadWide(
    #     border_focus=colors["accent"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    #     margin=7,
    # ),
    # layout.TreeTab(
    #     font="JetBrainsMono Nerd Font",
    #     fontsize=12,
    #     border_width=3,
    #     padding_left=0,
    #     padding_x=8,
    #     padding_y=6,
    #     section_top=8,
    #     section_bottom=8,
    #     section_padding=8,
    #     section_fontsize=12,
    #     sections=[""],
    #     active_bg=colors["highlight"],
    #     active_fg=colors["bg"],
    #     inactive_bg=colors["bg1"],
    #     inactive_fg=colors["fg"],
    #     section_fg=colors["gray"],
    #     bg_color=colors["bg"],
    #     previous_on_rm=True,
    # ),
    # layout.Columns(
    #     border_focus=colors["accent"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    #     margin=7,
    # ),
    # layout.Floating(
    #     border_focus=colors["accent"],
    #     border_normal=colors["bg2"],
    #     border_width=3,
    # ),
]

# ── GROUPS  ──────────────────
# FIX: Monitor arrangement
groups_names = [
    # ── Monitor 0 (DP-1 / 32"): 1 ──────────────────
    (
        "1",
        {
            "label": "1",
            "layout": "max",
            "screen_affinity": 2,  # DP-1 is screen 2
            "matches": [
                Match(wm_class="kitty"),
                Match(wm_class="helium"),
                Match(wm_class="gwenview"),
                Match(wm_class="Zathura"),
                Match(wm_class="Godot"),
            ],
        },
    ),
    # ── Monitor 1 (DVI-D-0 / 22" horizontal): 2 ──────────────────
    (
        "2",
        {
            "label": "2",
            "layout": "max",
            "screen_affinity": 0,  # DVI-D-0 is screen 0
            "matches": [
                Match(wm_class="Emacs"),
                Match(wm_class="dolphin"),
                Match(wm_class="io.github.alainm23.planify"),
                Match(wm_class="Joplin"),
                Match(wm_class="obsidian"),
                Match(wm_class="krita"),
                Match(wm_class="kdeconnect-app"),
                Match(wm_class="PixiEditor.Desktop"),
                Match(wm_class="vivaldi-stable"),
                Match(wm_class="brave-browser"),
                Match(wm_class="Blender"),
            ],
        },
    ),
    # ── Monitor 2 (HDMI-0 / 22" vertical): 3 ──────────────────
    (
        "3",
        {
            "label": "3",
            "layout": "max",
            "screen_affinity": 1,  # HDMI-0 is screen 1
            "matches": [
                Match(wm_class="Logseq"),
                Match(wm_class="dev.zed.Zed"),
                Match(wm_class="jetbrains-studio"),
                Match(wm_class="org.kde.okular"),
            ],
        },
    ),
]

groups = [Group(name, **kwargs) for name, kwargs in groups_names]

# ── SCRATCHPAD  ──────────────────
groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "emacs_scratchpad",
                # NOTE: check modules/home-manager/shell/scripts.nix
                "doom-terminal",
                x=0.05,
                y=0.05,
                width=0.9,
                height=0.9,
                opacity=1.0,
                on_focus_lost_hide=True,
            ),
        ],
    )
)

for name, kwargs in groups_names:
    keys.append(
        Key(
            [mod, "shift"],
            name,
            lazy.window.togroup(name),
            desc=f"Move window to group {name}",
        )
    )

# ── Widget defaults  ──────────────────
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=3,
    background=colors["bg"],
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()


# NOTE: Tab setup
def make_tasklist():
    return widget.TaskList(
        font="JetBrainsMono Nerd Font",
        fontsize=12,
        foreground=colors["fg"],
        background=colors["bg"],
        border=colors["bg1"],
        unfocused_border=colors["bg1"],
        urgent_border=colors["bg2"],
        borderwidth=0,
        padding_x=8,
        padding_y=4,
        margin=2,
        icon_size=0,
        title_width_method="uniform",
        markup_focused=f"<span foreground='{colors['accent']}'><b>{{}}</b></span>",
        markup_normal="{}",
        highlight_method="block",
        rounded=False,
    )


def create_widgets():
    return [
        # ── Layout indicator  ──────────────────
        widget.CurrentLayout(
            font="JetBrainsMono Nerd Font Bold",
            fontsize=12,
            foreground=colors["highlight"],
            background=colors["bg1"],
            padding=12,
        ),
        # ── Group box ────────────────────────────────────────────
        widget.GroupBox(
            font="JetBrainsMono Nerd Font Bold",
            fontsize=14,
            background=colors["bg1"],
            active=colors["fg"],
            inactive=colors["gray"],
            highlight_method="line",
            highlight_color=[colors["bg1"], colors["bg1"]],
            this_current_screen_border=colors["highlight"],
            this_screen_border=colors["accent"],
            other_current_screen_border=colors["blue"],
            other_screen_border=colors["gray"],
            urgent_border=colors["red"],
            borderwidth=3,
            padding_x=8,
            padding_y=4,
            disable_drag=True,
            hide_unused=False,
            urgent_alert_method="line",
            use_mouse_wheel=False,
        ),
        widget.TextBox(
            text="",
            fontsize=22,
            foreground=colors["bg1"],
            background=colors["bg"],
            padding=0,
        ),
        # ── Spacer pushes right side widgets to the right ────────
        widget.Spacer(),
        # ── System stats block ───────────────────────────────────
        widget.TextBox(
            text="",
            fontsize=22,
            foreground=colors["bg1"],
            background=colors["bg"],
            padding=0,
        ),
        widget.ThermalSensor(
            format="CPU {temp:.0f}{unit}",
            font="JetBrainsMono Nerd Font",
            fontsize=12,
            foreground=colors["green"],
            foreground_alert=colors["red"],
            background=colors["bg1"],
            threshold=80,
            tag_sensor="Core 0",
            update_interval=2,
            padding=6,
        ),
        widget.NvidiaSensors(
            format="GPU {temp}°C",
            font="JetBrainsMono Nerd Font",
            fontsize=12,
            foreground=colors["aqua"],
            foreground_alert=colors["red"],
            background=colors["bg1"],
            threshold=75,
            update_interval=2,
            padding=6,
        ),
        widget.CPU(
            format="󰻠 {load_percent}%",
            font="JetBrainsMono Nerd Font",
            fontsize=12,
            foreground=colors["purple"],
            background=colors["bg1"],
            update_interval=2,
            padding=6,
        ),
        widget.Memory(
            format="󰍛 {MemUsed:.0f}{mm}",
            font="JetBrainsMono Nerd Font",
            fontsize=12,
            foreground=colors["blue"],
            background=colors["bg1"],
            padding=6,
        ),
        # ── Volume block ─────────────────────────────────────────
        widget.PulseVolume(
            fmt="󰕾 {}",
            font="JetBrainsMono Nerd Font",
            fontsize=12,
            foreground=colors["purple"],
            background=colors["bg1"],
            padding=10,
        ),
        # ── Clock block ──────────────────────────────────────────
        widget.Clock(
            format="%Y-%m-%d  %I:%M",
            font="JetBrainsMono Nerd Font Bold",
            fontsize=12,
            foreground=colors["aqua"],
            background=colors["bg1"],
            padding=10,
        ),
    ]


screens = [
    # ── Screen 0: DVI-D-0 (22") Horizontal ──────────────────
    Screen(
        bottom=bar.Bar(
            [make_tasklist()],
            28,
            background=colors["bg"],
            opacity=1.00,
            margin=[4, 6, 0, 6],
        ),
    ),
    # ── Screen 1: HDMI-0 (22") Vertical ──────────────────────
    Screen(
        bottom=bar.Bar(
            [make_tasklist()],
            28,
            background=colors["bg"],
            opacity=1.00,
            margin=[4, 6, 0, 6],
        ),
    ),
    # ── Screen 2: DP-1 (32") ─────────────────────────────────
    Screen(
        top=bar.Bar(
            create_widgets(),
            30,
            background=colors["bg"],
            opacity=1.00,
            margin=[4, 6, 0, 6],
        ),
        bottom=bar.Bar(
            [make_tasklist()],
            28,
            background=colors["bg"],
            opacity=1.00,
            margin=[4, 6, 0, 6],
        ),
    ),
]
# ── Mouse bindings ──────────────────────────────────────────
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# ── Window rules ──────────────────────────────────────────
dgroups_key_binder = None

# ── Focus behaviour: Mouse moves to active screen; focus follows mouse ──────────────────────────────────────────
cursor_warp = True
follow_mouse_focus = True

bring_front_click = False

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="nm-connection-editor"),
    ],
    border_focus=colors["accent"],
    border_normal=colors["bg2"],
    border_width=3,
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"


# ── Autostart hook ──────────────────────────────────────────
@hook.subscribe.startup_once
def autostart():
    # NOTE: check modules/scripts/qtile-autostart.nix
    subprocess.Popen(["qtile-autostart"])
