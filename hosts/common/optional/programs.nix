# Optional system programs (PAM, GPG, etc.)
# Uncomment to enable.

_:

{
  # run unpatched dynamic binaries (binaries extracted from firmware)
  programs.nix-ld.enable = true;

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
