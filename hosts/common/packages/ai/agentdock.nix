# agentdock - Docker-based AI agent manager

{ pkgs, lib, ... }:

let
  agentdock = pkgs.rustPlatform.buildRustPackage {
    pname = "agentdock";
    version = "0.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "niniconi";
      repo = "agentdock";
      rev = "69de15153c4b51969116f0acf39b372349f841e8"; # v0.2.0
      hash = "sha256-+O135uc/5YDcpQ4BdCMwH382n+2w2woGheJhlTtsl3w=";
    };

    cargoHash = "sha256-3ybiaUUivYF2Yx6odzkkmSPZBuxGK3zzxuedMScMp6U=";

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
