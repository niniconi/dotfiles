# dotfiles - runtime deps (dotfiles-* subpackages)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ranger
    kitty
    wl-clipboard
    tree-sitter
    xwayland-satellite
    go
  ];
}
