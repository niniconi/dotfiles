# agentdock - Docker-based AI agent manager

{ pkgs, lib, ... }:

let
  agentdock = pkgs.rustPlatform.buildRustPackage {
    pname = "agentdock";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "niniconi";
      repo = "agentdock";
      rev = "10e310e58e95436cb77c7b4f3e78236dcb96f679"; # v0.1.0
      hash = "sha256-0WkNZR0HbXL2Qm8rqFc4voU1vRLNcChFJ6+MEXvpRTk=";
    };

    cargoHash = "sha256-fc05s2yEjsrPUEE2Arbw/WitIJkhtqB51Xqku8lvSeM=";

    doCheck = false;

    # build.rs exists only to hand these to a packager; cargoInstallHook drops them.
    postInstall = ''
      install -Dm644 target/completions/agentdock.bash $out/share/bash-completion/completions/agentdock
      install -Dm644 target/completions/_agentdock $out/share/zsh/site-functions/_agentdock
      install -Dm644 target/completions/agentdock.fish $out/share/fish/vendor_completions.d/agentdock.fish
    '';

    meta = {
      description = "Docker-based AI Agent Manager";
      homepage = "https://github.com/niniconi/agentdock";
      license = lib.licenses.mit;
      mainProgram = "agentdock";
      platforms = lib.platforms.unix;
    };
  };
in
{
  environment.systemPackages = [ agentdock ];
}
