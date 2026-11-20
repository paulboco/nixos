{ lib, pkgs, ... }:

{
    # Writes only the key below, other settings in kwinrc and System Settings keep working.
    # ElectricBorderDelay is an Int in the [Windows] group of kwin.kcfg (default 75).
    # KWin reads it on the next reconfigure, so log out and in if it does not apply at once.
    home.activation.kwinSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Display & Monitor > Screen Edges: activation delay (ms)
        run "$kw" --file kwinrc --group Windows --key ElectricBorderDelay 200
    '';
}
