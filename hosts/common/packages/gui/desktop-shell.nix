# desktop-shell - desktop shell components

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # desktop shell (moved from ai: Wayland desktop components)
    dms-shell
    # Wayland session runtime
    wl-clipboard
    xwayland-satellite
    # Phone connect daemon (GNOME-native KDE Connect alternative)
    valent
  ];
}
