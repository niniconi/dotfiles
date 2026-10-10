# golang - Go static analysis tooling

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go-tools
    golangci-lint
    go-critic
    gosec
    govulncheck
  ];
}
