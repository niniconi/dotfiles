# cargo.nix - Cargo extension tools

{ config, pkgs, lib, ... }:

let
  cargo-packager = pkgs.rustPlatform.buildRustPackage rec {
    pname = "cargo-packager";
    version = "0.11.8";

    src = pkgs.fetchCrate {
      inherit pname version;
      sha256 = "sha256-DjqrsomwtM5JzGrBIjfREZ15pUijza+/p+3CwXe+dSY=";
    };

    cargoHash = "sha256-rSNBn8CkqJN52ApHjhH6wJpy23DLv5BSN/rjWZrl5mk=";

    meta = with lib; {
      description = "Executable packager, bundler and updater";
      homepage = "https://github.com/crabnebula-dev/cargo-packager";
      license = licenses.mit;
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    # Development
    cargo-expand       # show macro expansions
    cargo-watch        # watch for changes and rebuild
    cargo-generate     # generate projects from templates

    # Testing
    cargo-nextest      # better test runner
    cargo-hack         # feature combination testing
    cargo-fuzz         # fuzz testing

    # Profiling
    cargo-flamegraph   # flamegraph profiling
    cargo-valgrind     # memory profiling

    # Quality
    cargo-bloat        # binary size analysis
    cargo-spellcheck   # spell checking for docs/comments

    # Audit
    cargo-deny         # dependency license/vulnerability auditing
    cargo-audit        # security vulnerability auditing

    # Packaging & Release
    cargo-release      # release automation
    cargo-packager     # package applications
    cargo-zigbuild     # cross-compilation via zig
  ];
}
