{ ... }:

# Silences "Could not register app ID" warnings from Qt apps that have no
# portal app info on NixOS (seen with ksshaskpass during `git clone`).
# Harmless warnings only; ksshaskpass itself keeps working.
# Takes effect after the next login.
# Import from configuration.nix: imports = [ ./modules/qt-portal.nix ];

{
    environment.sessionVariables = {
        QT_NO_XDG_DESKTOP_PORTAL = "1";
    };
}