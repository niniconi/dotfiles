# Builders for a consuming flake. They assemble the same module set this
# repository uses for its own hosts, so the two cannot drift apart.
{ inputs, overlays }:

let
  inherit (inputs.nixpkgs) lib;

  # Secrets are the caller's business: withSecrets only says whether to wire
  # sops up, secretsDir says where the host files live.
  sopsSettings =
    {
      hostName,
      withSecrets,
      secretsDir,
    }:
    {
      enable = withSecrets;
      defaultFile =
        if withSecrets && secretsDir != null then secretsDir + "/hosts/${hostName}/secrets.yaml" else null;
      ageKeyPaths = lib.optionals withSecrets [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
in
{
  mkModules =
    {
      hostName,
      users ? { },
      diskDevice ? "",
      withSecrets ? false,
      secretsDir ? null,
      extraModules ? [ ],
    }:
    [
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.sops-nix.nixosModules.sops
      inputs.impermanence.nixosModules.impermanence
      inputs.self.nixosModules.desktop
      { nixpkgs.overlays = overlays; }
      (_: {
        dotfiles = {
          inherit hostName users diskDevice;
          sops = sopsSettings { inherit hostName withSecrets secretsDir; };
        };

        # impermanence and pwndbg are pinned by this flake, not by the caller.
        _module.args.inputs = builtins.removeAttrs inputs [ "self" ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users = lib.mapAttrs (userName: userConf: {
            imports = [
              inputs.self.homeManagerModules.default
            ]
            ++ lib.optional (userConf.home != null) userConf.home;
            home.username = lib.mkDefault userName;
            home.homeDirectory = lib.mkDefault "/home/${userName}";
          }) users;
        };
      })
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ extraModules;
}
