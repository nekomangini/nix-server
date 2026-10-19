{ ... }:

{
  # Enable policykit
  security.polkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users") &&
        (
          action.id == "org.freedesktop.udisks2.filesystem-mount" ||
          action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
          action.id == "org.freedesktop.udisks2.encrypted-unlock" ||
          action.id == "org.freedesktop.udisks2.eject-media" ||
          action.id == "org.freedesktop.udisks2.power-off-drive"
        )
      ) {
        return polkit.Result.YES;
      }
    });
  '';
}
