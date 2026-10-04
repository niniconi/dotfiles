# libvirt - KVM/QEMU virtualization tools

{
  config,
  lib,
  ...
}:

{
  # The daemon is not just another package: systemd.services.libvirtd puts
  # ${libvirt}/var/lib/sysconfig/libvirtd into its environment, which is a store
  # path reference. Leaving the daemon enabled would keep libvirt, and through
  # it qemu and virt-manager, in the closure even with those off oversizedPackages.
  virtualisation.libvirtd.enable = config.oversizedPackages.enable;

  users.users.administrator.extraGroups = lib.mkIf config.oversizedPackages.enable [ "libvirtd" ];
}
