# What the shared home module does not know. `home.username` and
# `home.homeDirectory` are derived from this file's key in hosts.nix.
{
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
