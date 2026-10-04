# ai - AI tools

{
  pkgs,
  ...
}:

{
  imports = [ ./coding-agents.nix ];

  environment.systemPackages = with pkgs; [
    aichat
    llama-cpp
    openclaw
  ];
}
