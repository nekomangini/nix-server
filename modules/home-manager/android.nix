{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    android-tools
    android-cli
    gradle
    xwayland-satellite
    # jdk17

    flutter
    ninja
    pkg-config
    mesa-demos

    # chromium # only use this if brave is not available
  ];

  home.sessionVariables = {
    # CHROME_EXECUTABLE = "${pkgs.vivaldi}/bin/vivaldi";   # flutter run -d web-server
    # CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium"; # flutter run -d chrome
    CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    # JAVA_HOME = "${pkgs.jdk17.home}";
    JAVA_HOME = "${pkgs.jdk21.headless.home}";
  };
}
