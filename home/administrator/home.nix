{ config, pkgs, userName, ... }:

{
  imports = [
    ../common/core
    ../common/optional/kitty.nix
    ../common/optional/neovim.nix
    ../common/optional/tmux.nix
    ../common/optional/niri.nix
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
