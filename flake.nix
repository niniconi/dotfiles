{
  description = "niniconi's NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg.url = "github:pwndbg/pwndbg";
  };

  outputs =
    { self, nixpkgs, disko, home-manager, lanzaboote, nur, sops-nix, pwndbg, ... }@inputs:
    let
      system = "x86_64-linux";
      # Machine identity — change these when deploying to another machine.
      userName = "administrator";
      hostName = "nixos";
      diskDevice = "/dev/nvme0n1";
      secretFile = "/persist/secrets/administrator-password";

      # Check if private secrets submodule exists
      secretsPath = ./secrets/default.nix;
      profilesPath = ./secrets/profiles.nix;
      hasSecrets = builtins.pathExists secretsPath;

      # Load profiles from secrets or use empty default
      profiles = if hasSecrets then import profilesPath else {};
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs userName hostName diskDevice secretFile profiles;
        };
        modules = [
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          sops-nix.nixosModules.sops
          ./modules/options.nix
          ./modules/sops.nix
          ./hosts/nixos
          { nixpkgs.overlays = [ nur.overlays.default ]; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit userName hostName profiles;
            };
            home-manager.users.${userName} = import ./home/administrator/home.nix;
          }
          # Load private secrets if submodule exists, otherwise load empty module
          (if hasSecrets then secretsPath else { ... }: { })
        ];
      };
    };
}
