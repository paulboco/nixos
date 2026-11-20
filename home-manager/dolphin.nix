{ lib, pkgs, ... }:

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

    # Writes only the keys below, other settings in dolphinrc and Dolphin's Configure dialog keep working.
    # All keys are in the [General] group of ~/.config/dolphinrc.
    home.activation.dolphinSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        kw="${pkgs.kdePackages.kconfig}/bin/kwriteconfig6"

        # Folders & Tabs: keep a single window, open new folders in tabs
        run "$kw" --file dolphinrc --group General --key OpenExternallyCalledFolderInNewTab true

        # Folders & Tabs: show full path in title bar
        run "$kw" --file dolphinrc --group General --key ShowFullPathInTitlebar true

        # Folders & Tabs: always show tab bar
        run "$kw" --file dolphinrc --group General --key AlwaysShowTabBar true

        # Status & Location bars: status bar full width (enum, the other choice is "Small")
        run "$kw" --file dolphinrc --group General --key ShowStatusBar FullWidth

        # Status & Location bars: editable location bar
        run "$kw" --file dolphinrc --group General --key EditableUrl true

        # Status & Location bars: full path inside location bar
        run "$kw" --file dolphinrc --group General --key ShowFullPath true
    '';
}
