{
  config,
  lib,
  ...
}:

{
  # Set your time zone.
  time.timeZone = config.dotfiles.timeZone;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = config.dotfiles.locale;
    extraLocaleSettings = lib.genAttrs [
      "LC_ADDRESS"
      "LC_IDENTIFICATION"
      "LC_MEASUREMENT"
      "LC_MONETARY"
      "LC_NAME"
      "LC_NUMERIC"
      "LC_PAPER"
      "LC_TELEPHONE"
      "LC_TIME"
    ] (_: config.dotfiles.locale);
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = config.dotfiles.xkbLayout;
    variant = config.dotfiles.xkbVariant;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # Enable flakes, automatic store maintenance and optimization
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # SSH is configured in modules/ssh.nix using profiles options

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = config.dotfiles.stateVersion; # Did you read the comment?
}
