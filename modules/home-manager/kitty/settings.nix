{ ... }:

{
  programs.kitty.settings = {
    # Font configuration
    font_family = "FiraCode Nerd Font";
    bold_font = "FiraCode Nerd Font Bold";
    italic_font = "FiraCode Nerd Font Italic";
    bold_italic_font = "FiraCode Nerd Font Bold Italic";
    font_size = "10.0";

    # Cursor settings
    cursor_shape = "block";
    cursor_blink_interval = "0.5";
    cursor_stop_blinking_after = "15.0";
    cursor_trail = 1;
    cursor_trail_decay = "0.1 0.4";
    cursor_trail_start_threshold = 0;

    # Scrollback
    scrollback_lines = 10000;
    scrollback_pager = "less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";

    # Mouse
    mouse_hide_wait = "3.0";
    open_url_with = "default";
    copy_on_select = "no";

    # Performance tuning
    repaint_delay = 10;
    input_delay = 3;
    sync_to_monitor = "yes";

    # Window layout
    remember_window_size = "yes";
    initial_window_width = "1200";
    initial_window_height = "700";
    window_padding_width = 0;
    window_border_width = "1.0";
    draw_minimal_borders = "yes";

    # Tab bar
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    tab_powerline_style = "slanted";
    tab_title_template = "{index}: {title}";

    # Advanced
    shell_integration = "no-cursor";
    allow_remote_control = "yes";
    # listen_on = "unix:/tmp/kitty";
    listen_on = "unix:/tmp/kitty-$\{KITTY_PID\}";

    # Bell
    enable_audio_bell = "no";
    visual_bell_duration = "0.0";
    window_alert_on_bell = "yes";
    bell_on_tab = "yes";

    # Opacity and blur
    background_opacity = "0.96";
    background_blur = 32;
    dynamic_background_opacity = "yes";

    # Confirm close
    confirm_os_window_close = -1;
  };
}
