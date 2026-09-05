# modules/sops.nix - sops-nix secret management
{ config, lib, pkgs, userName, profiles, ... }:

let
  hasSecrets = builtins.pathExists ../secrets/default.nix;
  profile = profiles.${userName} or {};
  ssh = profile.ssh or {};
  hosts = ssh.hosts or {};

  validHosts = lib.filter (h: h.sopsSecret or null != null) (builtins.attrValues hosts);

  # Auto-generate sops secret for each SSH host with sopsSecret configured
  sshSopsSecrets = lib.listToAttrs (lib.concatMap (host: 
    let
      baseName = builtins.baseNameOf host.sopsSecret;
    in [
      {
        name = host.sopsSecret;
        value = {
          path = "/home/${userName}/.ssh/${baseName}";
          owner = userName;
          mode = "0600";
        };
      }
      {
        name = "${host.sopsSecret}_pub";
        value = {
          path = "/home/${userName}/.ssh/${baseName}.pub";
          owner = userName;
          mode = "0644";
        };
      }
    ]
  ) validHosts);
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
