{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    delta
  ];

  # Deploy the exact .gitconfig from dotfiles
  home.file = {
    ".gitconfig".source = ./../../git/dot_gitconfig;
  };
}
