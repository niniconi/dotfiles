# hosts/common/optional/sing-box.nix - sing-box proxy service
{ config, lib, pkgs, userName, profiles, ... }:

let
  profile = profiles.${userName} or {};
  singBox = profile.sing-box or {};
  enabled = singBox.enable or false;
  settings = singBox.settings or {};
in
{
  services.sing-box = {
    enable = enabled;
    inherit settings;
  };
}
