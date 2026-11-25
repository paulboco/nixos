{ ... }:
{
    fileSystems."/mnt/shared" = {
        device = "/dev/disk/by-uuid/1DE0-DB30";
        fsType = "exfat";
        options = [
            "uid=1000"
            "gid=100"
            "nofail"
            "x-gvfs-show"
        ];
    };
}