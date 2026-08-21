{ config, pkgs, ... }:

{
  xdg.configFile."tmux" = {
    force = true;
    source = ../../../tmux/dot_config/tmux;
    recursive = true;
  };
}
