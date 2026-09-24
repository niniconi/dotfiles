# valent - Phone Connect (KDE Connect protocol) via Valent

{ pkgs, ... }:

{
  # Valent implements the KDE Connect protocol for GNOME. The module provides
  # the package and opens TCP/UDP 1714-1764; the daemon itself is started from
  # the niri config (spawn-at-startup "valent" "--gapplication-service").
  programs.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };

  # Valent advertises and browses _kdeconnect._udp through the Avahi D-Bus
  # interface, so Avahi is required for device discovery on the LAN.
  # Service publishing stays off (avahi's publish.enable defaults to false).
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
  };
}
