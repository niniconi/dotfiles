# ai - AI tools

{
  pkgs,
  ...
}:

{
  imports = [
    ./agentdock.nix
    ./coding-agents.nix
  ];

  environment.systemPackages = with pkgs; [
    aichat
    llama-cpp
    openclaw
  ];
}
