# daily - daily applications

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # daily apps
    jellyfin-media-player
    bitwarden-desktop
    mpv
    logseq
    # markdown editor (GTK4, lightweight)
    apostrophe
  ];
}
