{
  description = "niniconi's NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      # Machine identity — change these when deploying to another machine.
      userName = "administrator";
      hostName = "nixos";
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs userName hostName;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Top-level specialArgs do NOT propagate into home-manager's
            # internal evalModules — pass them explicitly here.
            home-manager.extraSpecialArgs = {
              inherit userName;
            };
            home-manager.users.${userName} = import ./home.nix;
          }
        ];
      };
    };
}
