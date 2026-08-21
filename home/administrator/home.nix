{ config, pkgs, userName, ... }:

{
  imports = [
    ../common/core
    ../common/optional/kitty.nix
    ../common/optional/neovim.nix
    ../common/optional/tmux.nix
    ../common/optional/niri.nix
    ../common/optional/ranger.nix
    ../common/optional/hyprland.nix
    ../common/optional/firefox.nix
  ];

  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # XDG user directories (English names)
  xdg.userDirs = {
    enable = true;
    desktop = "Desktop";
    documents = "Documents";
    download = "Downloads";
    music = "Music";
    pictures = "Pictures";
    projects = "Projects";
    publicShare = "Public";
    templates = "Templates";
    videos = "Videos";
    createDirectories = true;
  };

  # Let home-manager manage the session
  home.sessionPath = [ "$HOME/.local/bin" ];
}
