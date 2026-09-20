# misc - miscellaneous virtualization tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bubblewrap
  ];
}
