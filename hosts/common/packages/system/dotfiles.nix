# dotfiles - runtime deps (dotfiles-* subpackages)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ranger
    kitty
    neovim
    # xterm-kitty terminfo: fixes zsh line editing over SSH from kitty
    kitty.terminfo
    tree-sitter
  ];
}
