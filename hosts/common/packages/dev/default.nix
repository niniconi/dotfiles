# dev - development tools
# subcategories: toolchain, rust, java, mobile, web, db, media-prod

{ ... }:

{
  imports = [
    ./toolchain.nix
    ./rust.nix
    ./java.nix
    ./mobile.nix
    ./web.nix
    ./db.nix
    ./media-prod.nix
  ];
}
