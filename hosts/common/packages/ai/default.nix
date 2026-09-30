# ai - AI tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aichat
    llama-cpp
    openclaw
    # coding agents
    opencode
  ];
}
