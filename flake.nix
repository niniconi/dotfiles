# flake.nix
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
    {
      nixpkgs,
      disko,
      home-manager,
      lanzaboote,
      nur,
      sops-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Host configuration manifest (nested structure for clarity)
      hosts = import ./hosts/hosts.nix;

      # Check if private secrets submodule exists
      secretsPath = ./secrets/default.nix;
      profilesPath = ./secrets/profiles.nix;
      hasSecrets = builtins.pathExists secretsPath;

      # Load profiles from secrets or use empty default
      profiles = if hasSecrets then import profilesPath else { };

      # Generate all user keys list
      # Format: ["administrator@nixos" "developer@workstation"]
      allUserKeys = builtins.concatMap (
        hostName:
        let
          hostConf = hosts.${hostName};
          userNames = builtins.attrNames hostConf.users;
        in
        map (userName: "${userName}@${hostName}") userNames
      ) (builtins.attrNames hosts);
    in
    {
      # nixosConfigurations supports two formats:
      # - "username@hostname" for deploying single user
      # - "hostname" for deploying all users on that host
      nixosConfigurations =
        # User-level configurations (username@hostname)
        (builtins.listToAttrs (
          map (
            userKey:
            let
              parts = nixpkgs.lib.splitString "@" userKey;
              userName = builtins.elemAt parts 0;
              hostName = builtins.elemAt parts 1;
              hostConf = hosts.${hostName};
              userConf = hostConf.users.${userName};
            in
            {
              name = userKey;
              value = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit inputs profiles;
                  inherit hostName;
                  # Only include this user for single-user deployment
                  users = {
                    ${userName} = userConf;
                  };
                  inherit (hostConf) diskDevice;
                };
                modules = [
                  disko.nixosModules.disko
                  lanzaboote.nixosModules.lanzaboote
                  sops-nix.nixosModules.sops
                  ./modules/options.nix
                  ./modules/validation.nix
                  ./modules/sops.nix
                  ./hosts/${hostName}
                  { nixpkgs.overlays = [ nur.overlays.default ]; }
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      extraSpecialArgs = {
                        inherit hostName profiles;
                      };
                    };
                  }
                  {
                    home-manager = {
                      users.${userName} = import userConf.home;
                      extraSpecialArgs = {
                        inherit hostName profiles;
                        inherit userName;
                      };
                    };
                  }
                  (if hasSecrets then secretsPath else _: { })
                ];
              };
            }
          ) allUserKeys
        ))
        //
          # Host-level configurations (hostname, includes all users)
          (builtins.listToAttrs (
            map (hostName: {
              name = hostName;
              value = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                  inherit inputs profiles;
                  inherit hostName;
                  users = hosts.${hostName}.users;
                  diskDevice = hosts.${hostName}.diskDevice;
                };
                modules = [
                  disko.nixosModules.disko
                  lanzaboote.nixosModules.lanzaboote
                  sops-nix.nixosModules.sops
                  ./modules/options.nix
                  ./modules/validation.nix
                  ./modules/sops.nix
                  ./hosts/${hostName}
                  { nixpkgs.overlays = [ nur.overlays.default ]; }
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      extraSpecialArgs = {
                        inherit hostName profiles;
                      };
                    };
                  }
                ]
                ++ builtins.concatMap (
                  userName:
                  let
                    userConf = hosts.${hostName}.users.${userName};
                  in
                  [
                    {
                      home-manager = {
                        users.${userName} = import userConf.home;
                        extraSpecialArgs = {
                          inherit hostName profiles;
                          inherit userName;
                        };
                      };
                    }
                  ]
                ) (builtins.attrNames hosts.${hostName}.users)
                ++ [
                  (if hasSecrets then secretsPath else _: { })
                ];
              };
            }) (builtins.attrNames hosts)
          ))
        //
          # VM configurations (for testing with QEMU)
          # Usage: nixos-rebuild build-vm --flake .#nixos-vm
          {
            "nixos-vm" = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs profiles;
                hostName = "nixos";
              };
              modules = [
                ./hosts/nixos-vm
                { nixpkgs.overlays = [ nur.overlays.default ]; }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                      hostName = "nixos";
                      userName = "administrator";
                      inherit profiles;
                    };
                    users.administrator = import ./home/nixos/administrator/home.nix;
                  };
                }
              ];
            };
          };
    };
}
