# lua - Lua development toolchain (neovim config, repo root .stylua.toml)

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
    luajit
    stylua
    luaPackages.luacheck
  ];
}
