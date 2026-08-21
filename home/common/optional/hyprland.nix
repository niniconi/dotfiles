{ config, pkgs, ... }:

{
  xdg.configFile."hypr" = {
    force = true;
    source = ../../../hyprland/dot_config/hypr;
    recursive = true;
  };
}
