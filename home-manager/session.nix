{ lib, pkgs, ... }:

{
    # Writes only the keys below, other settings in ksmserverrc and System Settings keep working.
    # Both keys are in the [General] group of ~/.config/ksmserverrc.
    home.activation.sessionSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Desktop Session > General: do not ask for confirmation on shutdown, restart and logout
        # The KCM writes this key with a lower case "c". KDE bug 489179 says it now only
        # controls the cancel prompt for a specific action, so confirm the behavior after login.
        run "$kw" --file ksmserverrc --group General --key confirmLogout false

        # Desktop Session > Session Restore: start with an empty session
        # Enum choice name from ksmserver's kcfg (older releases wrote "default" for this).
        run "$kw" --file ksmserverrc --group General --key loginMode emptySession
    '';
}
