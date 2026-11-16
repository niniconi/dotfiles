# The home-manager half of the desktop. A user imports this and adds the
# identity settings (username, home directory, state version).
{ ... }:

{
  imports = [
    ../../home/common/core
    ../../home/common/optional/kitty.nix
    ../../home/common/optional/neovim.nix
    ../../home/common/optional/tmux.nix
    ../../home/common/optional/niri.nix
    ../../home/common/optional/ranger.nix
    ../../home/common/optional/hyprland.nix
    ../../home/common/optional/firefox.nix
    ../../home/common/optional/ssh.nix
  ];
}
