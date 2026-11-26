{ pkgs, lib, ... }:

let
    # Task manager pins, in order
    pinnedApps = [
        "applications:systemsettings.desktop"
        "applications:org.kde.dolphin.desktop"
        "applications:sublime_text.desktop"
        "applications:sublime_merge.desktop"
        "applications:chromium-browser.desktop"
        "applications:firefox.desktop"
        "applications:org.kde.konsole.desktop"
    ];

    # Plasma script: write launchers to every task manager widget
    pinScript = pkgs.writeText "pin-launchers.js" ''
        const launchers = ${builtins.toJSON pinnedApps};
        for (const panel of panels()) {
            for (const widget of panel.widgets()) {
                if (widget.type === "org.kde.plasma.icontasks"
                    || widget.type === "org.kde.plasma.taskmanager") {
                    widget.currentConfigGroup = ["General"];
                    widget.writeConfig("launchers", launchers);
                }
            }
        }
    '';

    # Send script to plasmashell over D-Bus; retry until it's up
    pinApps = pkgs.writeShellApplication {
        name = "plasma-pin-apps";
        runtimeInputs = [ pkgs.kdePackages.qttools pkgs.coreutils ];
        text = ''
            for _ in $(seq 1 30); do
                if qdbus org.kde.plasmashell /PlasmaShell \
                    org.kde.PlasmaShell.evaluateScript "$(cat ${pinScript})"; then
                    exit 0
                fi
                sleep 2
            done
            exit 1
        '';
    };
in
{
    # One-shot user service, run at each Plasma login
    systemd.user.services.plasma-pin-apps = {
        Unit = {
            Description = "Pin apps in the Plasma task manager";
            After = [ "plasma-workspace.target" ];
            PartOf = [ "graphical-session.target" ];
        };
        Service = {
            Type = "oneshot";
            ExecStart = lib.getExe pinApps;
        };
        Install.WantedBy = [ "plasma-workspace.target" ];
    };
}
