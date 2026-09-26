{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.myModules.emacs;
  emacsPackage = cfg.package.pkgs.withPackages (epkgs: [
    epkgs.treesit-grammars.with-all-grammars
  ]);
in
{
  options.myModules.emacs = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.emacs-pgtk;
      description = "Emacs variant to use (e.g. emacs-pgtk for Wayland, emacs-gtk for X11)";
    };

    enableDartFlutter = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to set DART_SDK and FLUTTER_ROOT session variables";
    };
  };

  config = {
    services.emacs = {
      enable = true;
      startWithUserSession = "graphical";
      package = emacsPackage;
    };

    programs.emacs = {
      enable = true;
      package = emacsPackage;
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
  };
}
