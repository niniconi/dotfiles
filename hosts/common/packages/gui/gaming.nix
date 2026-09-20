# gaming - games and emulators

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # games/emulators
    ruffle
    retroarch
    libretro-core-info
  ];
}
