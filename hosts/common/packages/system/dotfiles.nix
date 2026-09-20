# dotfiles - runtime deps (dotfiles-* subpackages)

{ pkgs, ... }:

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
