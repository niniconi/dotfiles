# virtual - virtualization/container tools

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
