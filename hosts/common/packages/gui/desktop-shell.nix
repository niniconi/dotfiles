# desktop-shell - desktop shell components

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dms-shell
    # Wayland session runtime
    wl-clipboard
    xwayland-satellite
  ];
}
