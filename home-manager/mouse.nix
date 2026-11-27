{ lib, pkgs, ... }:

{
    # Writes only the keys below, other settings in kcminputrc and System Settings keep working.
    # Replace VENDOR, PRODUCT and NAME with the values from the [Libinput][...][...][...] header
    # in ~/.config/kcminputrc (see home-manager-setup.md, step 3).

    # [paulboco@nixos:~]$ grep -n "^\[Libinput\]" ~/.config/kcminputrc
    # 1:[Libinput][1149][8257][Kensington Slimblade Trackball]
    home.activation.mouseSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"
        run "$kw" --file kcminputrc \
            --group Libinput --group 1149 --group 8257 --group "Kensington Slimblade Trackball" \
            --key NaturalScroll true
        run "$kw" --file kcminputrc \
            --group Libinput --group 1149 --group 8257 --group "Kensington Slimblade Trackball" \
            --key PointerAcceleration -- -0.800
        run "$kw" --file kcminputrc \
            --group ButtonRebinds --group Mouse \
            --key ExtraButton1 "MouseButton,274"
    '';
}

