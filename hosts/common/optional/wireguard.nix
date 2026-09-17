# hosts/common/optional/wireguard.nix - WireGuard VPN service
{ config, lib, pkgs, hostName, profiles, ... }:

let
  hostProfile = profiles.${hostName} or {};
  wg = hostProfile.wireguard or {};
in
{
  networking.wg-quick = lib.mkIf (wg.enable or false) {
    interfaces = wg.interfaces or {};
  };
}
