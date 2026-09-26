{ ... }:
{
  # Desktop-specific groups and packages
  users.users.nekomangini = {
    extraGroups = [
      "networkmanager"
      "wheel"
      "input" # For ydotool
      "uinput" # For ydotool
    ];
  };
}
