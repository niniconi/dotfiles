# secrets/default.nix - NixOS module that loads profiles
{ config, lib, ... }:

let
  profilesData = import ./profiles.nix;
in
{
  profiles = profilesData;
}
