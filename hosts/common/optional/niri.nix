{ pkgs, ... }:

{
  # niri - Wayland compositor. Official module registers the niri session
  # for display managers, sets up xdg portals and gnome-keyring.
  programs.niri = {
    enable = true;
    useNautilus = false; # avoid pulling nautilus; FileChooser falls back to gtk
  };

  services.desktopManager = {
    gnome.enable = true;
  };

  # Display manager: run niri as the desktop session.
  # Active: SDDM graphical login.
  # Alternatives are commented out below; to test one, comment the active
  # block and uncomment the alternative, then nixos-rebuild switch.
  services.displayManager = {
    enable = true;
    gdm.enable = true;
    defaultSession = "niri";
  };
  # Alternative: greetd + tuigreet (TUI login)
  # services.greetd = {
  #   enable = true;
  #   settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember";
  # };

  # Alternative: manual startup (no login manager)
  # Log in on a TTY and run "niri-session".
}
