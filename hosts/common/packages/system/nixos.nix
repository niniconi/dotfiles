# nixos.nix - Nix ecosystem CLI tools
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nixos-rebuild wrapper
    nh

    # diskless installer
    nixos-anywhere

    # image-based NixOS builds (qcow2, OCI, VM)
    colmena

    # deployment over SSH/rsync
    deploy-rs

    # sops: sops-nix decrypts at build time, the CLI is for editing secrets by hand
    sops

    # age: key handling for the sops age recipients
    age

    # better nix build output
    nix-output-monitor

    # nixos version diff
    nvd

    # nix-index + nix-locate: file-to-package database
    nix-index

    # lint (anti-patterns)
    statix

    # formatter
    nixfmt

    # dead code removal
    deadnix

    # home-manager CLI
    home-manager

    nixos-container
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
