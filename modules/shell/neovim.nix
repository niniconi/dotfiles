{ config, pkgs, ... }:

{
  xdg.configFile."nvim" = {
    force = true;
    source = ../../neovim/dot_config/nvim;
    recursive = true;
  };
}
