# daily - daily applications

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # daily apps
    thunderbird
    moonlight-qt
    libreoffice
    jellyfin-media-player
    bitwarden-desktop
    sunshine
    mpv
    logseq
  ];
}
