# gui - desktop apps (design-utils + extra-utils + game-emulators)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # design/creation
    gimp
    inkscape
    krita
    blender
    pkgs.kdePackages.kdenlive
    obs-studio
    audacity
    opentabletdriver
    # daily apps
    thunderbird
    moonlight-qt
    libreoffice
    jellyfin-media-player
    bitwarden-desktop
    sunshine
    mpv
    logseq
    # games/emulators
    ruffle
    retroarch
    libretro-core-info
    # desktop shell (moved from ai: Wayland desktop components)
    dms-shell
  ];
}
