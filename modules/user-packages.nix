{ config, pkgs, ... }:

let
    # Sublime Text in an empty network namespace (no internet, no LAN).
    # Sublime Merge is a separate package and is left untouched.
    # Compare network namespaces for shell and Sublime Text with:
    # `readlink /proc/self/ns/net /proc/$(pgrep -nx sublime_text)/ns/net`
    # They should be different.
    sublime-text-offline = pkgs.symlinkJoin {
        name = "sublime-text-offline-${pkgs.sublime4.version}";
        paths = [ pkgs.sublime4 ];
        postBuild = ''
            rm $out/bin/*
            cat > $out/bin/sublime_text <<'EOF'
            #!${pkgs.runtimeShell}
            exec ${pkgs.bubblewrap}/bin/bwrap \
                --dev-bind / / \
                --unshare-net \
                --die-with-parent \
                ${pkgs.sublime4}/bin/sublime_text "$@"
            EOF
            chmod +x $out/bin/sublime_text
            for alias in subl sublime sublime4; do
                ln -s sublime_text $out/bin/$alias
            done
        '';
    };
in

{
    users.users."paulboco".packages = with pkgs; [
        # --- System ---
        tree
        rar
        unrar
        p7zip

        # --- IT ---
        git
        meld
        sublime-text-offline   # was: sublime4
        sublime-merge

        # --- Browsers ---
        firefox
        chromium

        # --- Media ---
        ffmpeg
        yt-dlp
        haruna
        gimp

        # --- Offive ---
        libreoffice
    ];

    # Sublime Text (sublime4) depends on the end-of-life OpenSSL 1.1
    # See `nixos-new-beginnings\_doc\sublime-text-network-reduction.md`
    nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w"
    ];
}
