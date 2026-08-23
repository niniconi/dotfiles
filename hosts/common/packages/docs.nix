# docs - documentation/manual (docs-utils)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    man-db
    man-pages
  ];
}
