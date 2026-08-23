# virtual - virtualization/containers (virtual-utils)
# service-based: docker/libvirtd/waydroid run as system services

{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;

  users.users.administrator.extraGroups = [ "docker" "libvirtd" ];

  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    docker
    docker-compose
    docker-buildx
    virt-manager
    waydroid
    dive
    bubblewrap
  ];
}
