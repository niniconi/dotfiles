# modules/options.nix - Custom option definitions for public-private separation
{ lib, ... }:

let
  sshHostSubmodule = lib.types.submodule {
    options = {
      hostname = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Remote hostname or IP";
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "root";
        description = "Remote user name";
      };
      port = lib.mkOption {
        type = lib.types.int;
        default = 22;
        description = "Remote SSH port";
      };
      identityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to identity file (auto-derived from sopsSecret if not set)";
      };
      sopsSecret = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Sops secret name for private key (e.g., 'ssh/id_ed25519_github')";
      };
      forwardX11 = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable X11 forwarding";
      };
      extraOptions = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Additional SSH config options";
      };
    };
  };
in
{
  # Export submodule types for use in other modules
  options.profiles = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        git = {
          name = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Git commit author name (not set if null)";
          };
          email = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Git commit author email (not set if null)";
          };
          signingKey = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Git signing key (GPG key ID or SSH key path)";
          };
        };
        ssh = {
          authorizedKeys = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "User's SSH public keys (empty = not configured)";
          };
          hosts = lib.mkOption {
            type = lib.types.attrsOf sshHostSubmodule;
            default = { };
            description = "SSH host configurations (empty = not configured)";
          };
        };
      };
    });
    default = { };
    description = "User profiles configuration map";
  };
}
