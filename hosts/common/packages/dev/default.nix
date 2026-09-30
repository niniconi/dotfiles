# dev - development tools

{ ... }:

{
  imports = [
    ./toolchain.nix
    ./rust.nix
    ./java.nix
    ./web.nix
    ./db.nix
    ./media-prod.nix
    ./lua.nix
    ./lsp.nix
  ];
}
