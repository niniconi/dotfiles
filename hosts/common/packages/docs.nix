# docs - documentation/manual (docs-utils)

{ pkgs, ... }:

{
  documentation.enable = true;
  documentation.man.enable = true;
  documentation.nixos.enable = true;
  environment.systemPackages = with pkgs; [
    man-pages-posix
  ];
}
