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
  };

  outputs =
    { self, nixpkgs, disko, home-manager, lanzaboote, ... }@inputs:
    let
      system = "x86_64-linux";
      # Machine identity — change these when deploying to another machine.
      userName = "administrator";
      hostName = "nixos";
      diskDevice = "/dev/nvme0n1";
      secretFile = "/persist/secrets/administrator-password";
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs userName hostName diskDevice secretFile;
        };
        modules = [
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Top-level specialArgs do NOT propagate into home-manager's
            # internal evalModules — pass them explicitly here.
            home-manager.extraSpecialArgs = {
              inherit userName;
            };
            home-manager.users.${userName} = import ./home/administrator/home.nix;
          }
        ];
      };
    };
}
