# nixos.nix - Nix ecosystem CLI tools

{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # nixos-rebuild wrapper
    nh

    # better nix build output
    nix-output-monitor

    # nixos version diff
    nvd

    # nix-index + nix-locate: file-to-package database
    nix-index

    # home-manager CLI
    home-manager
  ];

  # direnv + nix-direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # nix-index: auto-update database weekly
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
