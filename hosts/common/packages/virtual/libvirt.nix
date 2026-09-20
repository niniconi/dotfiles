# libvirt - KVM/QEMU virtualization tools

{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  users.users.administrator.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
  ];
}
