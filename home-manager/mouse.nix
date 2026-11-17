{ lib, pkgs, ... }:

{
    # Writes only the keys below, so other settings in kcminputrc
    # and System Settings keep working. Replace VENDOR, PRODUCT and
    # NAME with the values from the [Libinput][...][...][...] header
    # in ~/.config/kcminputrc (see home-manager-setup.md, step 3).
    home.activation.mouseSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"
        run "$kw" --file kcminputrc \
            --group Libinput --group VENDOR --group PRODUCT --group "NAME" \
            --key NaturalScroll true
        run "$kw" --file kcminputrc \
            --group Libinput --group VENDOR --group PRODUCT --group "NAME" \
            --key PointerAcceleration -- -0.800
    '';
}
