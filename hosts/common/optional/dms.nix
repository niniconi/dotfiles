{ pkgs, ... }:

let
  # Official DMS plugin monorepo (no tags/releases, pin an exact commit)
  dmsPlugins = pkgs.fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "dms-plugins";
    rev = "829922a8f11949b1c13ae8bd14d7176f9165b6f5";
    hash = "sha256-KYx+n1stxLT4R9IDVRx3/Cl7TjCcBZjnQchbrXaBT2o=";
  };
  # The dms-shell module installs src as the plugin directory itself, so the
  # monorepo subdirectory has to be lifted to the root (plugin.json at top)
  dankKDEConnectPlugin = pkgs.runCommand "DankKDEConnect-plugin" { } ''
    mkdir -p $out
    cp -r ${dmsPlugins}/DankKDEConnect/. $out/
    cp ${dmsPlugins}/LICENSE $out/
  '';
in

{
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    # Phone Connect plugin: talks to the Valent daemon over D-Bus
    # (no SFTP/gvfs setup; notifications, battery, ping and clipboard only)
    plugins.DankKDEConnect.src = dankKDEConnectPlugin;
  };
}
