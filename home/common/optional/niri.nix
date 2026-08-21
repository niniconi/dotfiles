{ config, pkgs, ... }:

{
  xdg.configFile."niri" = {
    force = true;
    source = ../../../niri/dot_config/niri;
    recursive = true;
  };
}
