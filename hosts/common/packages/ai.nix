# ai - AI tools (ai-utils)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aichat
    llama-cpp
    openclaw
  ];
}
