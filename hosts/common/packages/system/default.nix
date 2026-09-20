# system - system tools
# subcategories: base-cli, fs, nixos, dotfiles, fonts

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
