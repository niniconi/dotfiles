# lsp - language servers provided by nixpkgs (no mason downloads)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang-tools # clangd, clang-format, clang-tidy
    rust-analyzer
    pyright # needs nodejs (see dev/web.nix)
    lua-language-server
    bash-language-server
    jdt-language-server # needs jdk (see dev/java.nix)
    php # runtime for phpactor
    phpactor
    zls
    typescript-language-server # needs nodejs
    vscode-langservers-extracted # html / css / json language servers
    asm-lsp
    sqls
    yaml-language-server
    marksman
    nixd
  ];
}
