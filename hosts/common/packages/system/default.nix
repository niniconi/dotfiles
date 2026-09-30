# system - system tools

{ ... }:

{
  imports = [
    ./base-cli.nix
    ./fs.nix
    ./nixos.nix
    ./dotfiles.nix
    ./fonts.nix
  ];
}
