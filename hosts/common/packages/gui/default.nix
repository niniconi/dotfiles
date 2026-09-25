# gui - desktop applications
# subcategories: design, daily, gaming, desktop-shell

{ ... }:

{
  imports = [
    ./design.nix
    ./daily.nix
    ./gaming.nix
    ./desktop-shell.nix
  ];
}
