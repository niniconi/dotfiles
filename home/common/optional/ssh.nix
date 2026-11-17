{
  config,
  lib,
  osConfig,
  ...
}:

let
  profile =
    osConfig.dotfiles.profiles.${osConfig.dotfiles.hostName}.users.${config.home.username} or { };
  ssh = profile.ssh or { };
  hosts = ssh.hosts or { };

  # An explicit identityFile wins; otherwise the key materialised from
  # sopsSecret is used, which sops.nix writes to the same path.
  identityFileFor =
    host:
    let
      explicit = host.identityFile or null;
    in
    if explicit != null then
      explicit
    else if host.sopsSecret or null != null then
      "~/.ssh/${builtins.baseNameOf host.sopsSecret}"
    else
      null;
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = lib.mapAttrs' (
      name: host:
      let
        identityFile = identityFileFor host;
      in
      lib.nameValuePair name (
        {
          HostName = host.hostname or name;
          User = host.user or "root";
          Port = host.port or 22;
        }
        // lib.optionalAttrs (identityFile != null) { IdentityFile = identityFile; }
        // lib.optionalAttrs (host.forwardX11 or false) { ForwardX11 = "yes"; }
        // (host.extraOptions or { })
      )
    ) hosts;
  };
}
