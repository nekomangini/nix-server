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

  cases = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: pkg: ''
      *${lib.toLower name}*) exec ${withGrammars pkg}/bin/emacs "$@" ;;
    '') cfg.sessions
  );

  # `emacs` launcher that picks the build from the running session
  emacsBySession = pkgs.writeShellScriptBin "emacs" ''
    session=$(printf '%s' "''${XDG_CURRENT_DESKTOP:-''${XDG_SESSION_DESKTOP:-}}" \
      | ${pkgs.coreutils}/bin/tr '[:upper:]' '[:lower:]')

    case "$session" in
      ${cases}
      *) exec ${basePackage}/bin/emacs "$@" ;;
    esac
  '';
in

{
  options.myModules.emacs = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.emacs-pgtk;
      description = "Fallback Emacs variant, used when no entry in `sessions` matches";
    };

    sessions = lib.mkOption {
      type = lib.types.attrsOf lib.types.package;
      default = { };
      example = lib.literalExpression "{ i3 = pkgs.emacs-gtk; niri = pkgs.emacs-pgtk; }";
      description = ''
        Emacs variant per session. Keys are matched against
        $XDG_CURRENT_DESKTOP (case-insensitive).
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
