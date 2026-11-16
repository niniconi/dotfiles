# sops-nix wiring: turns the sopsSecret entries of a user's ssh profile into
# secrets, and optionally points sops at the host's secrets file. Everything it
# assumes about the layout is an option, so a consuming flake that keeps its
# secrets elsewhere can either configure these or leave the module out.
{
  config,
  lib,
  ...
}:

let
  cfg = config.dotfiles;
  sopsCfg = cfg.sops;

  hostProfile = cfg.profiles.${cfg.hostName} or { };

  secretsForUser =
    userName:
    let
      profile = hostProfile.users.${userName} or { };
      sshHosts = (profile.ssh or { }).hosts or { };
      declared = lib.filter (h: h.sopsSecret or null != null) (builtins.attrValues sshHosts);

      materialise =
        host:
        let
          baseName = builtins.baseNameOf host.sopsSecret;
          home = config.users.users.${userName}.home;
          key = {
            path = "${home}/.ssh/${baseName}";
            owner = userName;
            mode = "0600";
          };
          pubKey = {
            path = "${home}/.ssh/${baseName}.pub";
            owner = userName;
            mode = "0644";
          };
        in
        [
          {
            name = "${userName}/${host.sopsSecret}";
            value = key;
          }
        ]
        ++ lib.optional sopsCfg.materializePubKey {
          name = "${userName}/${host.sopsSecret}_pub";
          value = pubKey;
        };
    in
    lib.listToAttrs (lib.concatMap materialise declared);

  allSecrets = lib.foldl' (acc: userName: acc // secretsForUser userName) { } (
    builtins.attrNames cfg.users
  );
in
{
  config = lib.mkIf sopsCfg.enable {
    sops = {
      defaultSopsFile = lib.mkIf (sopsCfg.defaultFile != null) (lib.mkDefault sopsCfg.defaultFile);
      defaultSopsFormat = lib.mkDefault sopsCfg.format;
      age.sshKeyPaths = sopsCfg.ageKeyPaths;
      secrets = allSecrets;
    };
  };
}
