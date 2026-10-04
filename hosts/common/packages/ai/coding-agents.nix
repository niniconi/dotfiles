# coding-agents - terminal AI coding agents
#
# Split out of default.nix because these are the packages whose build some hosts
# take from a newer nixpkgs than the channel flake.lock pins.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  # A daily driver should not move under its feet, but a throwaway image is
  # worthless if it is only ever tested against the pinned channel.
  options.aiCodingAgents.channel = lib.mkOption {
    type = lib.types.enum [
      "stable"
      "unstable"
    ];
    default = "stable";
    description = "Which nixpkgs to build the coding agents from.";
  };

  config.environment.systemPackages =
    if config.aiCodingAgents.channel == "unstable" then
      [
        pkgs.opencode-unstable
        pkgs.pi-coding-agent-unstable
      ]
    else
      [
        pkgs.opencode
        pkgs.pi-coding-agent
      ];
}
