{ pkgs, ... }:

{
  xdg.configFile."nvim" = {
    force = true;
    source = ../../../neovim;
    recursive = true;
  };

  home.packages = with pkgs; [
    nixfmt
  ];
}
