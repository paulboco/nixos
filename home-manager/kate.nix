{ lib, pkgs, ... }:

{
    # Writes only the keys below, other settings in katerc and Kate's Configure dialog keep working.
    # Kate's editor settings come from KTextEditor, which uses the [KTextEditor Renderer]
    # and [KTextEditor View] groups of ~/.config/katerc.
    home.activation.kateSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Appearance > General: line height multiplier
        run "$kw" --file katerc --group "KTextEditor Renderer" --key "Line Height Multiplier" 1.7

        # Appearance > Statusbar: show line ending type
        run "$kw" --file katerc --group "KTextEditor View" --key "Show Line Ending Type in Statusbar" true

        # Some KTextEditor releases shipped this key with a typo ("Shoe"), so set that spelling too.
        run "$kw" --file katerc --group "KTextEditor View" --key "Shoe Line Ending Type in Statusbar" true
    '';
}
