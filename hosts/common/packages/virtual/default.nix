# virtual - virtualization/container tools
# subcategories: docker, libvirt, waydroid, kubernetes

{ ... }:

{
  imports = [
    ./docker.nix
    ./libvirt.nix
    ./waydroid.nix
    ./kubernetes.nix
    ./misc.nix
  ];
}
