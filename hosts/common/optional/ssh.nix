# hosts/common/optional/ssh.nix - SSH server configuration
{ config, lib, pkgs, userName, profiles, ... }:

let
  profile = profiles.${userName} or { ssh.authorizedKeys = []; };
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

  users.users.${userName} = lib.mkIf (profile.ssh.authorizedKeys != []) {
    openssh.authorizedKeys.keys = profile.ssh.authorizedKeys;
  };
}
