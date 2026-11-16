{ config, lib, pkgs, ... }:

# Keeps Num Lock engaged at every stage:
#   1. text consoles (TTY1-6)
#   2. SDDM login screen
#   3. Plasma session
#
# Assumes Plasma 6 + SDDM. 
# Import from configuration.nix: imports = [ ./modules/numlock.nix ];

{
    # 1. Text consoles
    systemd.services.numlock-tty = {
        description = "Enable numlock on text consoles";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.bash}/bin/bash -c 'for tty in /dev/tty{1..6}; do ${pkgs.kbd}/bin/setleds -D +num < $tty; done'";
        };
    };

    # 2. SDDM login screen (documented for the X11 greeter; may not apply on a Wayland greeter)
    services.displayManager.sddm.settings.General.Numlock = "on";

    # 3. Plasma session
    #    System-wide default read by KConfig via XDG_CONFIG_DIRS, so no
    #    home-manager is needed. 0 = on, 1 = off, 2 = leave unchanged.
    #    A user-level ~/.config/kcminputrc overrides this if it sets NumLock.
    environment.etc."xdg/kcminputrc".text = ''
        [Keyboard]
        NumLock=0
    '';
}
