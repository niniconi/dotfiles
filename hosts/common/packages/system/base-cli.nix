# cli - general purpose CLI tools (base-utils + posting + docs-utils)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # archive/compression
    p7zip
    zip
    unzip
    # system info/monitoring
    file
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
    # remote shell
    openssh
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
    # crypto/tls CLI (cert inspection and generation)
    openssl
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
