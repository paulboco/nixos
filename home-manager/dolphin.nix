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
    home.activation.dolphinSettings =
        let
            kw = "${pkgs.kdePackages.kconfig}/bin/kwriteconfig6";

            # Write a key to ~/.config/dolphinrc
            dolphinrc = group: key: value:
                "run \"${kw}\" --file dolphinrc --group ${group} --key ${key} ${value}";

            # Write a key to the global view properties file (needs $viewdir, set below)
            viewProps = group: key: value:
                "run \"${kw}\" --file \"$viewdir/.directory\" --group ${group} --key ${key} ${value}";
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] (
            lib.concatStringsSep "\n" [
                # Folders & Tabs: keep a single window, open new folders in tabs
                (dolphinrc "General" "OpenExternallyCalledFolderInNewTab" "true")

                # Folders & Tabs: show full path in title bar
                (dolphinrc "General" "ShowFullPathInTitlebar" "true")

                # Folders & Tabs: always show tab bar
                (dolphinrc "General" "AlwaysShowTabBar" "true")

                # Status & Location bars: status bar full width (enum, the other choice is "Small")
                (dolphinrc "General" "ShowStatusBar" "FullWidth")

                # Status & Location bars: editable location bar
                (dolphinrc "General" "EditableUrl" "true")

                # Status & Location bars: full path inside location bar
                (dolphinrc "General" "ShowFullPath" "true")

                # General > Behavior: one common display style for all folders
                # (stops Dolphin remembering a view mode per folder)
                (dolphinrc "General" "GlobalViewProps" "true")

                # Folders & Tabs: show the close button on tabs
                (dolphinrc "General" "ShowCloseButtonOnTabs" "true")

                # Startup: open the home folder instead of restoring the last session's folders and tabs
                (dolphinrc "General" "RememberOpenedTabs" "false")
                (dolphinrc "General" "HomeUrl" "\"file://$HOME\"")

                # Show filter bar: off (the key is FilterBar, not ShowFilterBar)
                (dolphinrc "General" "FilterBar" "false")

                # View Modes > Details: preview icon size 32 px (the "Preview" slider).
                # IconSize is left at Dolphin's default.
                (dolphinrc "DetailsMode" "PreviewSize" "32")

                # The common display style is stored in a .directory file, not in dolphinrc.
                # [Dolphin] ViewMode: DolphinView::Mode, 0 = Icons, 1 = Details, 2 = Compact, 3 = Columns.
                # Version must match Dolphin's CurrentViewPropertiesVersion (4) or the file is discarded.
                # Written with kwriteconfig6 rather than home.file so Dolphin can still update the file.
                "viewdir=\"$HOME/.local/share/dolphin/view_properties/global\""
                "run mkdir -p \"$viewdir\""
                (viewProps "Dolphin" "ViewMode" "1")
                (viewProps "Dolphin" "Version" "4")

                # Always show hidden files (key is in the [Settings] group of the same file)
                (viewProps "Settings" "HiddenFilesShown" "true")
            ]
        );
}
