{ config, pkgs, ... }:

{
  xdg.configFile."kitty" = {
    force = true;
    source = ../../kitty/dot_config/kitty;
    recursive = true;
  };
}
