# coding-agents - terminal AI coding agents
#
# Split out of default.nix because these are the packages whose build some hosts
# take from a newer nixpkgs than the channel flake.lock pins.

{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.opencode
    pkgs.pi-coding-agent
  ];
}
