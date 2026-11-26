{ config, lib, pkgs, ... }:

# Swaps Page Up and End on every keyboard, at the kernel input level, so it
# applies on TTYs, SDDM, and both X11 and Wayland Plasma sessions.
#
# Import from configuration.nix: imports = [ ./modules/swap-pgup-end.nix ];
#
# Scancodes:
#   USB HID  : Page Up = 7004b, End = 7004d  (usage page 0x07, usage 0x4b / 0x4d)
#   PS/2 AT  : Page Up = e049,   End = e04f  (laptop built-in keyboards)

{
    services.udev.extraHwdb = ''
        # USB keyboards
        evdev:input:b0003*
         KEYBOARD_KEY_7004b=end
         KEYBOARD_KEY_7004d=pageup

        # Bluetooth keyboards
        evdev:input:b0005*
         KEYBOARD_KEY_7004b=end
         KEYBOARD_KEY_7004d=pageup

        # PS/2 / laptop built-in keyboards
        evdev:atkbd:*
         KEYBOARD_KEY_e049=end
         KEYBOARD_KEY_e04f=pageup
    '';
}
