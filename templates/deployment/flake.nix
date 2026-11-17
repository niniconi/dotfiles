# A deployment repository that takes its whole desktop from the dotfiles
# flake. Everything here is a fact about this machine; the configuration
# itself lives upstream.
{
  description = "Private deployment repo; the desktop comes from the dotfiles flake";

  inputs = {
    dotfiles.url = "github:niniconi/dotfiles";

    # Follow every input so package versions match the dotfiles repository
    # exactly. Without them the modules still evaluate, but against whatever
    # nixpkgs this flake would otherwise pick.
    nixpkgs.follows = "dotfiles/nixpkgs";
    nixpkgs-unstable.follows = "dotfiles/nixpkgs-unstable";
    home-manager.follows = "dotfiles/home-manager";
    nur.follows = "dotfiles/nur";
    sops-nix.follows = "dotfiles/sops-nix";
    disko.follows = "dotfiles/disko";
    lanzaboote.follows = "dotfiles/lanzaboote";
    impermanence.follows = "dotfiles/impermanence";
    pwndbg.follows = "dotfiles/pwndbg";
  };

  outputs =
    {
      nixpkgs,
      dotfiles,
      ...
    }:
    let
      system = "x86_64-linux";
      hosts = import ./hosts.nix;
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        hostName: hostConf:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = dotfiles.lib.mkModules {
            inherit hostName;
            inherit (hostConf) users diskDevice;
            withSecrets = (hostConf.secrets or null) != null;
            secretsDir = hostConf.secrets or null;
            extraModules = hostConf.extraModules or [ ];
          };
        }
      ) hosts;
    };
}
