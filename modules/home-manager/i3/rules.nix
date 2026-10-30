{ ... }:

{
  xsession.windowManager.i3.config = {
    assigns = {
      "8" = [
        { class = "^brave-browser$"; }
        { class = "^gwenview$"; }
        { class = "^Zathura$"; }
      ];

      "9" = [
        { class = "^kitty$"; }
        { class = "^dev.zed.Zed$"; }
        { class = "^jetbrains-studio$"; }
        { class = "^Emacs$"; }
        { class = "^okular$"; }
        { class = "^io.github.alainm23.planify$"; }
      ];

      "10" = [
        { class = "^Vivaldi-stable$"; }
        { class = "^helium$"; }
        { class = "^dolphin$"; }
        { class = "^krita$"; }
        { class = "^obsidian$"; }
        { class = "^Logseq$"; }
        { class = "^Joplin$"; }
        { class = "^kdeconnect-app$"; }
        { class = "^PixiEditor.Desktop$"; }
        { class = "^Blender$"; }
        { class = "^Godot$"; }
      ];

    };

    workspaceOutputAssign = [
      {
        workspace = "8";
        output = "DP-1";
      }
      {
        workspace = "9";
        output = "HDMI-0";
      }
      {
        workspace = "10";
        output = "DVI-D-0";
      }
    ];
  };
}
