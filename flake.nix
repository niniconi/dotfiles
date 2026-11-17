# flake.nix
{
  description = "niniconi's NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Not pinned to a release branch: the image and VM hosts exist to be tested
    # against current releases, so a couple of packages track this instead. Every
    # other host stays on nixpkgs above.
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Resolved lazily, so a host that never asks for the unstable variants does
      # not pay for instantiating a second nixpkgs.
      unstablePkgs = nixpkgs-unstable.legacyPackages.${system};

      unstableCodingAgents = _final: _prev: {
        opencode-unstable = unstablePkgs.opencode;
        pi-coding-agent-unstable = unstablePkgs.pi-coding-agent;
        deepseek-harness-unstable = unstablePkgs.deepseek-harness;
      };

      overlays = [
        nur.overlays.default
        unstableCodingAgents
      ];

      # Container images are tagged by source date and revision instead of
      # "latest", so a pulled image can be traced back to the checkout it was
      # built from.
      ociVersion = "${nixpkgs.lib.substring 0 8 (self.lastModifiedDate or "19700101")}-${
        self.shortRev or self.dirtyShortRev or "unknown"
      }";

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
      # `nix flake init -t <repo>#flutter` copies templates/flutter/flake.nix
      # verbatim into the new project, so the template has to be a flake that
      # works on its own rather than one that imports from here. One directory
      # per template so a second one cannot collide with this one's flake.lock.
      templates = {
        flutter = {
          path = ./templates/flutter;
          description = "Flutter development and build environment";
        };
        deployment = {
          path = ./templates/deployment;
          description = "Deployment repo that takes its desktop from this flake";
        };
      };

      # Everything a consuming flake needs. lib/default.nix assembles these the
      # same way this repository's own hosts are assembled.
      nixosModules = {
        desktop = ./modules/nixos/desktop.nix;
        impermanence = ./hosts/common/optional/impermanence.nix;
        swap = ./hosts/common/optional/swap.nix;
      };

      homeManagerModules.default = ./modules/home/default.nix;

      overlays.default = overlays;

      lib = import ./lib {
        inherit inputs overlays;
      };

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
                modules = self.lib.mkModules {
                  inherit hostName;
                  inherit (hostConf) diskDevice;
                  # Only include this user for single-user deployment
                  users = {
                    ${userName} = userConf;
                  };
                  withSecrets = hasSecrets;
                  secretsDir = ./secrets;
                  extraModules = [ ./hosts/${hostName} ] ++ nixpkgs.lib.optional hasSecrets secretsPath;
                };
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
                modules = self.lib.mkModules {
                  inherit hostName;
                  users = hosts.${hostName}.users;
                  diskDevice = hosts.${hostName}.diskDevice;
                  withSecrets = hasSecrets;
                  secretsDir = ./secrets;
                  extraModules = [ ./hosts/${hostName} ] ++ nixpkgs.lib.optional hasSecrets secretsPath;
                };
              };
            }) (builtins.attrNames hosts)
          ))
        //
          # Container image of the same desktop. Booted by the host kernel, so
          # there is no disk image and no bootloader, and it does not run
          # systemd either, so it needs no privileges.
          # Build: nh os build-image --image-variant oci --hostname nixos .#nixos-oci
          # Tag:   nix eval --raw .#nixosConfigurations.nixos-oci.config.system.build.images.oci.passthru.imageTag
          # Run:   docker run -it nixos-oci:<tag> bash
          {
            "nixos-oci" = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs profiles;
                hostName = "nixos";
                inherit ociVersion;
              };
              modules = [
                (self.lib.mkDotfilesModule {
                  hostName = "nixos";
                  users = {
                    administrator = { };
                  };
                })
                ./hosts/nixos-oci
                { nixpkgs.overlays = overlays; }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.administrator = {
                      imports = [
                        ./modules/home/default.nix
                        ./home/nixos/administrator/home.nix
                      ];
                      home = {
                        username = "administrator";
                        homeDirectory = "/home/administrator";
                      };
                    };
                  };
                }
              ];
            };
          }
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
                (self.lib.mkDotfilesModule {
                  hostName = "nixos";
                  users = {
                    administrator = { };
                  };
                })
                ./hosts/nixos-vm
                { nixpkgs.overlays = overlays; }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.administrator = {
                      imports = [
                        ./modules/home/default.nix
                        ./home/nixos/administrator/home.nix
                      ];
                      home = {
                        username = "administrator";
                        homeDirectory = "/home/administrator";
                      };
                    };
                  };
                }
              ];
            };
          }
        //
          # Same VM without the package groups that dominate its disk. It cannot
          # reuse ./hosts/nixos-vm for that: NixOS modules accumulate, so there
          # is no way to import a host file and then drop what it pulled in.
          # Usage: nh os build-vm .#nixos-vm-mini
          {
            "nixos-vm-mini" = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit inputs profiles;
                hostName = "nixos";
              };
              modules = [
                (self.lib.mkDotfilesModule {
                  hostName = "nixos";
                  users = {
                    administrator = { };
                  };
                })
                ./hosts/nixos-vm-mini
                { nixpkgs.overlays = overlays; }
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.administrator = {
                      imports = [
                        ./modules/home/default.nix
                        ./home/nixos/administrator/home.nix
                      ];
                      home = {
                        username = "administrator";
                        homeDirectory = "/home/administrator";
                      };
                    };
                  };
                }
              ];
            };
          };
    };
}
