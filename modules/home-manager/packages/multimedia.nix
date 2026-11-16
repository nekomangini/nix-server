{ pkgs, ... }:

{
  home.packages = with pkgs; [
    easytag
    picard
    playerctl
    vlc
    (blender.override { cudaSupport = true; })
    krita
    pixieditor
    gimp
    kdePackages.gwenview
  ];
}
