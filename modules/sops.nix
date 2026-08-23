# modules/sops.nix - sops-nix secret management
{ config, lib, pkgs, userName, profiles, ... }:

let
  hasSecrets = builtins.pathExists ../secrets/default.nix;
  profile = profiles.${userName} or { ssh.hosts = {}; };

  # Auto-generate sops secret for each SSH host with sopsSecret configured
  sshSopsSecrets = lib.mapAttrs' (name: host: {
    name = host.sopsSecret;
    value = {
      path = "/home/${userName}/.ssh/${builtins.baseNameOf host.sopsSecret}";
      owner = userName;
      mode = "0600";
    };
  }) (lib.filterAttrs (n: h: h.sopsSecret or null != null) profile.ssh.hosts);
in
{
  config = lib.mkIf hasSecrets {
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets = sshSopsSecrets;
    };
  };
}
