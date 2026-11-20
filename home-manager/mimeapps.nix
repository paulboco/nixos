{ lib, pkgs, ... }:

{
    # Default Applications is stored in ~/.config/mimeapps.list. xdg.mimeApps is not used
    # because it would replace the whole file with a read-only symlink, and System Settings
    # could no longer change any other default. This writes only the key below.
    # The desktop file name is sublime_text.desktop, from the nixpkgs sublime4 package,
    # so sublime4 must be installed (environment.systemPackages or home.packages).
    home.activation.mimeappsSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Default Applications > Documents > Text editor: Sublime Text
        run "$kw" --file mimeapps.list --group "Default Applications" --key "text/plain" "sublime_text.desktop"
    '';
}
