{ lib, pkgs, ... }:

{
    # The wallpaper lives in plasma-org.kde.plasma.desktop-appletsrc under
    # [Containments][<id>][Wallpaper]..., and the containment id differs per machine.
    # So instead of kwriteconfig6 this asks the running plasmashell to set it through its
    # scripting D-Bus API, which writes the right containment on every desktop.
    #
    # Plain Color is the org.kde.color plugin, with the color in [Wallpaper][org.kde.color][General].
    # The color is stored as "R,G,B", so #002000 is 0,32,0.
    #
    # This needs a running Plasma session. If plasmashell is not up (first boot, SSH rebuild),
    # the step is skipped and does nothing. Run "sudo nixos-rebuild switch" again from the desktop.
    home.activation.wallpaperSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

        script='
            var all = desktops();
            for (var i = 0; i < all.length; i++) {
                var d = all[i];
                d.wallpaperPlugin = "org.kde.color";
                d.currentConfigGroup = ["Wallpaper", "org.kde.color", "General"];
                d.writeConfig("Color", "0,32,0");
            }
        '

        # Wallpaper > Wallpaper type: Plain Color, #002000
        run ${pkgs.systemd}/bin/busctl --user call org.kde.plasmashell /PlasmaShell \
            org.kde.PlasmaShell evaluateScript s "$script" || true
    '';
}
