{ lib, pkgs, ... }:

{
    # A global theme is a bundle of keys (colors, widget style, icons, cursor, window
    # decoration), so setting LookAndFeelPackage alone would not switch them.
    # plasma-apply-lookandfeel sets the whole bundle the way the System Settings page does.
    #
    # It only runs when the theme differs, so later rebuilds do not reset color or icon
    # tweaks made afterwards. It needs a running Plasma session and is skipped otherwise.
    home.activation.themeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

        # Colors & Themes > Global Theme: Breeze Dark
        current="$(${pkgs.kdePackages.kconfig}/bin/kreadconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage)"
        if [ "$current" != "org.kde.breezedark.desktop" ]; then
            run ${pkgs.kdePackages.plasma-workspace}/bin/plasma-apply-lookandfeel -a org.kde.breezedark.desktop || true
        fi
    '';
}
