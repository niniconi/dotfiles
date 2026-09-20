# network - network tools
# subcategories: diagnostics, traffic, proxy/VPN, browsers

{ ... }:

{
  imports = [
    ./diagnostics.nix
    ./traffic.nix
    ./proxy-vpn.nix
    ./browsers.nix
  ];
}
