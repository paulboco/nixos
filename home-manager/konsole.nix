{ ... }:

{
    # Konsole keeps custom shortcuts in a kxmlgui file, not in konsolerc.
    # This file only overrides the actions listed below, the other defaults stay as they are.
    # The version is set high so Konsole does not discard this file as older than its shipped one.
    #
    # Note: Ctrl+C no longer sends SIGINT in Konsole once it is bound to Copy.
    # To keep an interrupt key, bind the "sigint-signal" action to something else here.
    home.file.".local/share/kxmlgui5/konsole/sessionui.rc".text = ''
        <!DOCTYPE gui SYSTEM "kpartgui.dtd">
        <gui name="konsole" version="9999">
            <ActionProperties scheme="Default">
                <Action name="edit_copy" shortcut="Ctrl+C"/>
                <Action name="edit_paste" shortcut="Ctrl+V"/>
            </ActionProperties>
        </gui>
    '';
}
