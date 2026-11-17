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

  mkDotfilesModule =
    {
      hostName,
      users ? { },
      diskDevice ? "",
      withSecrets ? false,
      secretsDir ? null,
    }:
    {
      imports = [ ../modules/dotfiles.nix ];

      dotfiles = {
        inherit hostName users diskDevice;
        sops = sopsSettings { inherit hostName withSecrets secretsDir; };
      };

      # impermanence and pwndbg are pinned by this flake, not by the caller.
      _module.args.inputs = inputs;
    };
in
{
  # The option tree on its own, for configurations that bring their own module
  # list: the test VMs and the container image.
  inherit mkDotfilesModule;

  # The whole desktop, wired the way this repository's own hosts are.
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
      ../modules/nixos/desktop.nix
      { nixpkgs.overlays = overlays; }
      (mkDotfilesModule {
        inherit
          hostName
          users
          diskDevice
          withSecrets
          secretsDir
          ;
      })
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users = lib.mapAttrs (userName: userConf: {
            imports = [
              ../modules/home/default.nix
            ]
            ++ lib.optional ((userConf.home or null) != null) userConf.home;
            home.username = lib.mkDefault userName;
            home.homeDirectory = lib.mkDefault "/home/${userName}";
          }) users;
        };
      }
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ extraModules;
}
