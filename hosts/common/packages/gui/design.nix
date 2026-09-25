# design - design/creation tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # design/creation
    gimp
    inkscape
    krita
    blender
    pkgs.kdePackages.kdenlive
    obs-studio
    audacity
    opentabletdriver
  ];
}
