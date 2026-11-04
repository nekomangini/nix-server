{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myModules.emacs;

  withGrammars =
    pkg:
    pkg.pkgs.withPackages (epkgs: [
      epkgs.treesit-grammars.with-all-grammars
    ]);

  basePackage = withGrammars cfg.package;
  x11Package = withGrammars cfg.x11Package;

  # One `case` arm per registered session, matched by substring (case-insensitive)
  cases = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: pkg: ''
      *${lib.toLower name}*) exec ${withGrammars pkg}/bin/emacs "$@" ;;
    '') cfg.sessions
  );

  # `emacs` launcher: picks the build from the running session.
  # 1. Explicit entries in `sessions`, matched by session name.
  # 2. Otherwise X11 sessions get x11Package, anything else gets `package`.
  # The daemon is a systemd user service and often cannot see XDG_CURRENT_DESKTOP,
  # so the session name and type are also read from logind.
  emacsBySession = pkgs.writeShellScriptBin "emacs" ''
    lower() { ${pkgs.coreutils}/bin/tr '[:upper:]' '[:lower:]'; }

    session=$(printf '%s' "''${XDG_CURRENT_DESKTOP:-''${XDG_SESSION_DESKTOP:-}}" | lower)
    type=""

    sid=$(${pkgs.systemd}/bin/loginctl show-user "$(${pkgs.coreutils}/bin/id -u)" -p Display --value 2>/dev/null)
    if [ -n "$sid" ]; then
      if [ -z "$session" ]; then
        session=$(${pkgs.systemd}/bin/loginctl show-session "$sid" -p Desktop --value 2>/dev/null | lower)
      fi
      type=$(${pkgs.systemd}/bin/loginctl show-session "$sid" -p Type --value 2>/dev/null)
    fi

    case "$session" in
      ${cases}
    esac

    if [ "$type" = x11 ]; then
      exec ${x11Package}/bin/emacs "$@"
    fi
    exec ${basePackage}/bin/emacs "$@"
  '';
in

{
  options.myModules.emacs = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.emacs-pgtk;
      description = "Default Emacs variant (Wayland sessions, and the fallback when nothing else matches)";
    };

    x11Package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.emacs-gtk;
      description = "Emacs variant for X11 sessions that have no entry in `sessions`";
    };

    sessions = lib.mkOption {
      type = lib.types.attrsOf lib.types.package;
      default = { };
      example = lib.literalExpression "{ i3 = pkgs.emacs-gtk; niri = pkgs.emacs-pgtk; }";
      description = ''
        Emacs variant per session. Keys are matched (case-insensitive substring)
        against $XDG_CURRENT_DESKTOP, or the logind session name when that is unset.
        When empty, no launcher is installed and `package` is used everywhere.
      '';
    };

    enableDartFlutter = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to set DART_SDK and FLUTTER_ROOT session variables";
    };
  };

  config = lib.mkMerge [
    {
      services.emacs = {
        enable = true;
        startWithUserSession = "graphical";
        package = basePackage;
      };

      programs.emacs = {
        enable = true;
        package = basePackage;
      };

      home.sessionVariables = {
        EMACS_BIN_PATH = "${config.home.homeDirectory}/.config/emacs/bin";
      }
      // lib.optionalAttrs cfg.enableDartFlutter {
        DART_SDK = "${pkgs.dart}";
        FLUTTER_ROOT = "${pkgs.flutter}";
      };

      home.sessionPath = [
        "${config.home.homeDirectory}/.config/emacs/bin"
      ];
    }

    # Only active when at least one session is registered
    (lib.mkIf (cfg.sessions != { }) {
      home.packages = [ (lib.hiPrio emacsBySession) ];
      systemd.user.services.emacs.Service.ExecStart =
        lib.mkForce "${emacsBySession}/bin/emacs --fg-daemon";
    })
  ];
}
