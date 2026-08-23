# ai - AI tools (ai-utils)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aichat
    llama-cpp
    openclaw
  ];
}
