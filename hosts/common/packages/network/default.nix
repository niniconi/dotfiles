# network - network tools

{ ... }:

{
  imports = [
    ./diagnostics.nix
    ./traffic.nix
    ./proxy-vpn.nix
    ./browsers.nix
    ./remote.nix
  ];
}
