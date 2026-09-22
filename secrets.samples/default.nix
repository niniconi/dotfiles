# secrets/default.nix - NixOS module that loads profiles
_:

let
  profilesData = import ./profiles.nix;
in
{
  profiles = profilesData;
}
