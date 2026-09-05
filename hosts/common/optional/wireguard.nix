# hosts/common/optional/wireguard.nix - WireGuard VPN service
{ config, lib, pkgs, userName, profiles, ... }:

let
  profile = profiles.${userName} or {};
  wg = profile.wireguard or {};
  enabled = wg.enable or false;
  interfaces = wg.interfaces or {};
in
{
  networking.wg-quick = lib.mkIf enabled {
    inherit interfaces;
  };
}
