#!/usr/bin/env bash
# Provision the toolbox inside a fresh archlinux-toolbox container.
#
# Baked into the image instead of run at build time: the Nix build sandbox has
# neither a network nor a Docker daemon, so pacman cannot reach the repositories
# while the image is assembled. Run this once with network access, e.g.
#   docker run -it --rm archlinux-toolbox /usr/local/bin/provision
set -euo pipefail

# --- Arch repositories: compiler/linker chain, language runtimes and the
#     fuzzers that ship in the official repos ---
pacman -Syu --needed --noconfirm \
  base-devel clang cmake ninja gdb \
  python python-pip python-virtualenv \
  nodejs npm go rust \
  git curl wget jq ripgrep fd tmux vim neovim \
  afl++ zzuf gobuster ssdeep radamsa

# --- AI coding agents ship through npm ---
npm install --global opencode-ai @mariozechner/pi-coding-agent

# --- fuzzers missing from the official repos ---
# Python: the interpreter is PEP 668 managed, hence the explicit override.
pip install --break-system-packages wfuzz regexploit
# Go: build straight from the module source.
GOBIN=/usr/local/bin go install github.com/ffuf/ffuf/v2@latest
# Rust: feroxbuster is not in the repositories.
cargo install --root /usr/local feroxbuster
# honggfuzz publishes no release tarball; build it from source.
git clone --depth 1 https://github.com/google/honggfuzz /tmp/honggfuzz
make -C /tmp/honggfuzz -j"$(nproc)"
make -C /tmp/honggfuzz install PREFIX=/usr/local
rm -rf /tmp/honggfuzz
