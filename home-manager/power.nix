{ lib, pkgs, ... }:

{
    # Writes only the keys below, other settings in powerdevilrc and System Settings keep working.
    # Keys come from PowerDevilProfileSettings.kcfg in KDE/powerdevil. The profile id is the
    # outer group, so every key is [AC][<Group>]. The machine is a desktop, so only the AC
    # profile is written. Duplicate the block with "Battery" and "LowBattery" if that changes.
    home.activation.powerSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Power Management > Suspend Session: when inactive: Do nothing
        # AutoSuspendAction is the PowerDevil::PowerButtonAction enum, 0 = NoAction.
        # The enum header could not be read, so confirm 0 with the diff trick in the handoff.
        run "$kw" --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0

        # Power Management > Display and Brightness: dim automatically: Never
        run "$kw" --file powerdevilrc --group AC --group Display --key DimDisplayWhenIdle false
        # Power Management > Display and Brightness: turn off screen: Never
        run "$kw" --file powerdevilrc --group AC --group Display --key TurnOffDisplayWhenIdle false

        # Power Management > Other Settings: switch to power profile: Performance
        # PowerProfile is a plain string holding the power-profiles-daemon profile name.
        run "$kw" --file powerdevilrc --group AC --group Performance --key PowerProfile performance
    '';
}
