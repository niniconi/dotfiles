# Package modules grouped by use case (migrated from deploy-repo/archlinux)
# Duplicates across groups are intentional for independent group toggling.

{ config, pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./dev.nix
    ./gui.nix
    ./network.nix
    ./recon.nix
    ./exploit.nix
    ./reversing.nix
    ./forensics.nix
    ./crypto.nix
    ./virtual.nix
    ./zh-cn.nix
    ./ai.nix
    ./docs.nix
    ./dotfiles.nix
  ];
}
