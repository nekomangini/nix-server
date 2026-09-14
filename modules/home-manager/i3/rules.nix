{ ... }:

{
  xsession.windowManager.i3.config = {
    assigns = {
      "8" = [
        { class = "^brave-browser$"; }
        { class = "^gwenview$"; }
        { class = "^Zathura$"; }
        { class = "^Godot$"; }
        { class = "^Blender$"; }
      ];
      "9" = [
        { class = "^Vivaldi-stable$"; }
        { class = "^helium$"; }
        # { class = "^ticktick$"; }
        { class = "^io.github.alainm23.planify$"; }
        { class = "^dolphin$"; }
        { class = "^krita$"; }
        { class = "^obsidian$"; }
        { class = "^Logseq$"; }
        { class = "^Joplin$"; }
        { class = "^kdeconnect-app$"; }
        { class = "^PixiEditor.Desktop$"; }
      ];

      "10" = [
        { class = "^kitty$"; }
        { class = "^dev.zed.Zed$"; }
        { class = "^jetbrains-studio$"; }
        { class = "^Emacs$"; }
        { class = "^okular$"; }
      ];
    };

    workspaceOutputAssign = [
      {
        workspace = "8";
        output = "DP-1";
      }
      {
        workspace = "9";
        output = "DVI-D-0";
      }
      {
        workspace = "10";
        output = "HDMI-0";
      }
    ];
  };
}
