{ ... }:
{
    fileSystems."/mnt/shared" = {
        device = "/dev/disk/by-uuid/YOUR-UUID-HERE";
        fsType = "exfat";
        options = [
            "uid=1000"
            "gid=100"
            "nofail"
            "x-gvfs-show"
        ];
    };
}