{ ... }:

{
    # Dolphin keeps its toolbar layout in a kxmlgui file, not in dolphinrc.
    # A user toolbar with noMerge="1" replaces the shipped one, so the default
    # actions are repeated here with "go_up" added after "go_forward".
    # The version is set high so Dolphin does not discard this file as older than its shipped one.
    #
    # Default actions copied from Dolphin master (gui version 50), compare with the installed
    # /run/current-system/sw/share/kxmlgui5/dolphin/dolphinui.rc if the toolbar looks off.
    home.file.".local/share/kxmlgui5/dolphin/dolphinui.rc".text = ''
        <!DOCTYPE gui SYSTEM "kpartgui.dtd">
        <gui name="dolphin" version="9999">
            <ToolBar name="mainToolBar" noMerge="1">
                <text context="@title:menu">Main Toolbar</text>
                <Action name="go_back"/>
                <Action name="go_forward"/>
                <Action name="go_up"/>
                <Action name="view_settings"/>
                <Action name="url_navigators"/>
                <Action name="split_view"/>
                <Action name="split_stash"/>
                <Action name="toggle_search"/>
                <Action name="hamburger_menu"/>
            </ToolBar>
        </gui>
    '';
}
