{ ... }:

{
    # Mask every sleep target so nothing can suspend or hibernate the machine
    systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
        suspend-then-hibernate.enable = false;
    };

    # Tell systemd/logind that sleep is not allowed (KDE then hides the options)
    systemd.sleep.settings.Sleep = {
        AllowSuspend = "no";
        AllowHibernation = "no";
        AllowHybridSleep = "no";
        AllowSuspendThenHibernate = "no";
    };

    # No action on idle, power key, suspend key or lid
    services.logind.settings.Login = {
        IdleAction = "ignore";
        HandlePowerKey = "ignore";
        HandleSuspendKey = "ignore";
        HandleHibernateKey = "ignore";
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
    };
}
