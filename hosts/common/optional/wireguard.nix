# hosts/common/optional/wireguard.nix - WireGuard VPN service
{
  lib,
  hostName,
  profiles,
  ...
}:

let
  hostProfile = profiles.${hostName} or { };
  wg = hostProfile.wireguard or { };
in
{
  networking.wg-quick = lib.mkIf (wg.enable or false) {
    interfaces = wg.interfaces or { };
  };
}
