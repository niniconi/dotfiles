# Fuzzing tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foundry
    slither-analyzer
  ];
}
