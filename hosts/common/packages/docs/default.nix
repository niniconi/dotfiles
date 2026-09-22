# docs - documentation/manual (docs-utils)

{ pkgs, ... }:

{
  documentation = {
    enable = true;
    man.enable = true;
    nixos.enable = true;
  };
  environment.systemPackages = with pkgs; [
    man-pages-posix
  ];
}
