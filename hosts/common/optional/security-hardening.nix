{ pkgs, ... }: {
  # Disable modifying users via mutable commands; all accounts are managed declaratively by Nix
  users.mutableUsers = false;

  security.protectKernelImage = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "init_on_alloc=1" # Zero-initialize allocated memory
      "init_on_free=1" # Clear memory upon freeing to prevent UAF vulnerabilities
      "page_alloc.shuffle=1"
      "slab_nomerge" # Isolate slab caches
      "kaslr"
    ];
    kernel.sysctl = {
      "kernel.unprivileged_bpf_disabled" = 1;
      "kernel.kptr_restrict" = 2;
    };
    blacklistedKernelModules = [
      "firewire-core"
      "thunderbolt"
    ];
  };

  nix.settings.auto-optimise-store = true;
}
