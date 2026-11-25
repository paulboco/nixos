{ config, pkgs, ... }:

{
    users.users."paulboco".packages = with pkgs; [
        # --- System ---
        tree
        rar
        unrar
        p7zip
        gparted

        # --- IT ---
        git
        meld
        sublime4
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
