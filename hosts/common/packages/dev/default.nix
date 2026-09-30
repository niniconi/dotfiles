# dev - development tools
# subcategories: toolchain, rust, java, web, db, media-prod

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
