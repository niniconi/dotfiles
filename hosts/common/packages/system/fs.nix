# fs tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Partitioning & Block Devices
    parted
    gptfdisk
    cryptsetup
    mdadm

    # File System Specific Utilities
    e2fsprogs
    btrfs-progs
    xfsprogs
    f2fs-tools
    exfatprogs
    ntfs3g
    dosfstools
    udftools
    squashfsTools
    nilfs-utils

    # Network & Remote File Systems
    nfs-utils
    cifs-utils
    sshfs
    davfs2
    openiscsi

    # FUSE & Virtual File Systems
    fuse-overlayfs
    archivemount

    # Monitoring, Analysis & Benchmarking
    duf
    gdu
    smartmontools
    fio
    hdparm
  ];
}
