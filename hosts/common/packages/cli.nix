# cli - general purpose CLI tools (base-utils + posting + docs-utils)

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # archive/compression
    p7zip
    zip
    unzip
    # system info/monitoring
    btop
    cpufetch
    fastfetch
    htop
    tmux
    inotify-tools
    usbutils
    dmidecode
    dosfstools
    # download
    wget
    # file search/browse
    bat
    fzf
    hexyl
    lsd
    ripgrep
    # data processing
    bc
    jq
    scc
    # dev helper CLI
    lazygit
    onefetch
    # HTTP clients
    httpie
    posting
    # git
    delta
    git-filter-repo
  ];
}
