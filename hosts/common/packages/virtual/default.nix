# virtual - virtualization/container tools

{ ... }:

{
  imports = [
    ./docker.nix
    ./docker-images.nix
    ./libvirt.nix
    ./waydroid.nix
    ./kubernetes.nix
    ./misc.nix
  ];
}
