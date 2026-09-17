# hosts/common/optional/ssh.nix - SSH server configuration
{ config, lib, pkgs, hostName, profiles, ... }:

let
  # Get all users' authorizedKeys for current host
  hostProfiles = profiles.${hostName} or {};
in
{
  services.openssh = {
    enable = false;  # Temporarily start with: sudo systemctl start sshd
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      X11Forwarding = false;
    };
  };

  # Configure authorizedKeys for all users
  users.users = lib.mapAttrs' (userName: profile:
    let
      ssh = profile.ssh or {};
      authorizedKeys = ssh.authorizedKeys or [];
    in
    lib.nameValuePair userName (lib.mkIf (authorizedKeys != []) {
      openssh.authorizedKeys.keys = authorizedKeys;
    })
  ) hostProfiles;
}
