# web - web development tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    geckodriver
  ];
}
