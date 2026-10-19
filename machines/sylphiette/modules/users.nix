{ ... }:
{
  # Desktop-specific groups and packages
  users.users.nekomangini = {
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers" # Android development
      "input" # For ydotool
      "uinput" # For ydotool
    ];
  };
}
