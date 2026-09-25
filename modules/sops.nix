# modules/sops.nix - sops-nix secret management
{
  lib,
  hostName,
  users,
  profiles,
  ...
}:

let
  hasSecrets = builtins.pathExists ../secrets/default.nix;

  # Generate SSH secrets for each user
  allUserSecrets = lib.foldl' (
    acc: userName:
    let
      hostProfiles = profiles.${hostName} or { };
      profile = hostProfiles.users.${userName} or { };
      ssh = profile.ssh or { };
      hosts = ssh.hosts or { };
      validHosts = lib.filter (h: h.sopsSecret or null != null) (builtins.attrValues hosts);

      userSecrets = lib.listToAttrs (
        lib.concatMap (
          host:
          let
            baseName = builtins.baseNameOf host.sopsSecret;
          in
          [
            {
              name = "${userName}/${host.sopsSecret}";
              value = {
                path = "/home/${userName}/.ssh/${baseName}";
                owner = userName;
                mode = "0600";
              };
            }
            {
              name = "${userName}/${host.sopsSecret}_pub";
              value = {
                path = "/home/${userName}/.ssh/${baseName}.pub";
                owner = userName;
                mode = "0644";
              };
            }
          ]
        ) validHosts
      );
    in
    acc // userSecrets
  ) { } (builtins.attrNames users);
in
{
  config = lib.mkIf hasSecrets {
    sops = {
      # Select secrets file by host
      defaultSopsFile = ../secrets/hosts/${hostName}/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets = allUserSecrets;
    };
  };
}
