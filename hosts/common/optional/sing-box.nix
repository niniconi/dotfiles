# hosts/common/optional/sing-box.nix - sing-box proxy service
{ config, lib, pkgs, hostName, profiles, ... }:

let
  hostProfile = profiles.${hostName} or {};
  singBox = hostProfile.sing-box or {};
in
{
  services.sing-box = {
    enable = singBox.enable or false;
    settings = singBox.settings or {};
  };
}
