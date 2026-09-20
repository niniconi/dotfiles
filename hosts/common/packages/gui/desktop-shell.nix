# desktop-shell - desktop shell components

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # desktop shell (moved from ai: Wayland desktop components)
    dms-shell
  ];
}
