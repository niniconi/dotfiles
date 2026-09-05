{ config, pkgs, ... }:

{
  xdg.configFile."ranger" = {
    force = true;
    source = ../../../ranger/dot_config/ranger;
    recursive = true;
  };
}
