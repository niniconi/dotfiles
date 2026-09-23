# daily - daily applications

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # daily apps
    thunderbird
    libreoffice
    jellyfin-media-player
    bitwarden-desktop
    mpv
    logseq
    # markdown editor (GTK4, lightweight)
    apostrophe
  ];
}
