{ pkgs, lib, ... }:

let
    # Set 230% scale on first enabled output; retry until kscreen is ready
    setScale = pkgs.writeShellApplication {
        name = "plasma-set-scale";
        runtimeInputs = [ pkgs.kdePackages.libkscreen pkgs.jq pkgs.coreutils ];
        text = ''
            for _ in $(seq 1 30); do
                output="$(kscreen-doctor -j 2>/dev/null \
                    | jq -r '[.outputs[] | select(.enabled)][0].name // empty')"
                if [ -n "$output" ]; then
                    kscreen-doctor "output.$output.scale.2.30"
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
    systemd.user.services.plasma-set-scale = {
        Unit = {
            Description = "Set display scale to 230%";
            After = [ "plasma-workspace.target" ];
            PartOf = [ "graphical-session.target" ];
        };
        Service = {
            Type = "oneshot";
            ExecStart = lib.getExe setScale;
        };
        Install.WantedBy = [ "plasma-workspace.target" ];
    };
}
