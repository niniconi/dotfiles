# blockchain - smart contract audit and blockchain tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foundry
    slither-analyzer
  ];
}
