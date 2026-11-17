# What the shared home module does not know. The username, home directory and
# the desktop modules themselves are supplied by whoever deploys this user.
{
  home.stateVersion = "26.05";

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
