{ config, lib, pkgs, ... }:

{
    # Secondary M2
    fileSystems."/mnt/secondary" = {

        device = "/dev/disk/by-uuid/86be43c0-946d-4589-b83a-072409d5bae5";
        fsType = "ext4";
        options = [ "defaults" "noatime" ];
    };

    # Hard Drive
    fileSystems."/mnt/harddrive" = {

        device = "/dev/disk/by-uuid/901f9f72-1549-44b5-899b-6e2475d30dd9";
        fsType = "ext4";
        options = [ "defaults" "noatime" ];
    };
}
