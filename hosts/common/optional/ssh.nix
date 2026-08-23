# hosts/common/optional/ssh.nix - SSH server configuration
{ config, lib, pkgs, userName, profiles, ... }:

let
  profile = profiles.${userName} or {};
  ssh = profile.ssh or {};
  authorizedKeys = ssh.authorizedKeys or [];
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

  users.users.${userName} = lib.mkIf (authorizedKeys != []) {
    openssh.authorizedKeys.keys = authorizedKeys;
  };
}
