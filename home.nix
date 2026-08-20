{ config, pkgs, userName, ... }:

{
  imports = [
    ./modules/shell/zsh.nix
    ./modules/shell/git.nix
    ./modules/shell/neovim.nix
    ./modules/shell/niri.nix
  ];

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # Let home-manager manage the session
  home.sessionPath = [ "$HOME/.local/bin" ];
}
