# The public interface of this flake's module set: everything a consuming
# flake has to supply. The values are republished through _module.args so the
# host and home modules keep their existing argument names; explicit args
# (specialArgs) still win over these, which lets a caller override any of them.
{
  config,
  lib,
  ...
}:

let
  userSubmodule = lib.types.submodule {
    options = {
      home = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Home-manager module deployed for this user; required when the host builder deploys it";
      };
      passwordFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to the file holding the user's hashed password";
      };
    };
  };
in
{
  # Imported here rather than left to the desktop module, so every configuration
  # declaring these options also gets `dotfiles.profiles`.
  imports = [ ./options.nix ];

  options.dotfiles = {
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Host this configuration is built for";
    };

    users = lib.mkOption {
      type = lib.types.attrsOf userSubmodule;
      default = { };
      description = "Users deployed by this configuration";
    };

    diskDevice = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Block device disko installs to; empty when the host has no disk layout";
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Shanghai";
      description = "System time zone";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "zh_CN.UTF-8";
      description = "Default and per-category locale";
    };

    xkbLayout = lib.mkOption {
      type = lib.types.str;
      default = "cn";
      description = "X11 keyboard layout";
    };

    xkbVariant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "X11 keyboard layout variant";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
      description = "NixOS state version, i.e. the release the host was first installed with";
    };

    persistencePath = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
      description = "Mount point of the volume that survives a tmpfs root";
    };

    sops = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Materialise SSH keys from sops secrets and enable sops-nix";
      };
      defaultFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "sops file used for secrets that do not name one";
      };
      format = lib.mkOption {
        type = lib.types.str;
        default = "yaml";
        description = "Format of the default sops file";
      };
      ageKeyPaths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Paths sops derives age keys from";
      };
      materializePubKey = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Also write the matching public key next to each SSH key";
      };
    };
  };

  config._module.args = {
    inherit (config.dotfiles) hostName users diskDevice;
    inherit (config.dotfiles) profiles;
  };
}
