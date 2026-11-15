{ config, pkgs, ... }:

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
        sublime4
        sublime-merge

        # --- Browsers ---
        chromium

        # --- Media ---
        ffmpeg
        yt-dlp
        haruna
        gimp

        # --- Offive ---
        libreoffice
    ];
}
