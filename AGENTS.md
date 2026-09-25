# AGENTS.md

NixOS flake dotfiles. Sources of truth on `nixos`: `flake.nix` (outputs),
`hosts/hosts.nix` (host manifest), `modules/` (profile options, validation, sops).

## Branches

Three long-lived lines. Every top-level path is owned by exactly one of them; there is
no shared editable area.

| Line | Purpose |
|---|---|
| `nixos` | Nix glue only: `flake.nix`, `flake.lock`, `hosts/`, `modules/`, `home/`, `secrets.samples/`. Declares and installs the content the other lines own; carries no dotfile content of its own. |
| `master` | Dotfile content and documentation: the raw config trees plus `doc/**` and `README.md`. |
| `neovim` | Neovim configuration, long-lived and independent. Every Neovim change is made here. |

A path owned by one line is **frozen** on the others: a copy that exists on another
line only serves that line's own build and must not be edited there. The `neovim` row
takes precedence over the `nixos` row for the files it lists.

| Owner | Paths |
|---|---|
| `nixos` | `.gitignore`, `AGENTS.md`, `flake.nix`, `flake.lock`, `hosts/**`, `modules/**`, `home/**`, `secrets.samples/**`, `secrets/` (never commit) |
| `neovim` | `neovim/**`, `home/common/optional/neovim.nix`, `hosts/common/packages/dev/lsp.nix`, `hosts/common/packages/dev/lua.nix`, `.stylua.toml` |
| `master` | `.gitmodules`, `doc/**`, `README.md`, `chromium/`, `dms/`, `gtk/`, `hyprland/`, `kitty/`, `niri/`, `ranger/`, `screenshot/`, `scripts/`, `termux/`, `tmux/`, `utils/`, `wallpaper/` |

- Before editing, run `git branch --show-current`. If the path you need belongs to another
  line, switch branches or stop and ask — never edit it on the current line.
- This file lives on `nixos`; the rules below describe all three lines.

Frozen copies that must not be renamed or deleted, because `nixos` resolves them:

- `hyprland/`, `kitty/`, `niri/`, `ranger/`, `tmux/`, `neovim/` — each is deployed by the
  matching `home/common/optional/<name>.nix` via
  `xdg.configFile."x".source = ../../../<dir>/dot_config/...`.
- `hosts/common/packages/dev/lsp.nix`, `hosts/common/packages/dev/lua.nix` and
  `home/common/optional/neovim.nix` — imported by `hosts/common/packages/dev/default.nix`
  and `home/nixos/administrator/home.nix`, which belong to `nixos`. Adding, renaming or
  removing one needs the matching change on `nixos` first; stop and ask instead of editing
  across lines.
- Renaming a dotfile directory breaks the build **on `nixos`**, so an eval run on `master` or
  `neovim` cannot catch it.

Sync direction: dotfile content changes land on `master`, so they reach the host only after
`master` is merged or cherry-picked into `nixos`. Nothing does that automatically.

On `neovim`, `nix eval` against a `nixosConfigurations.*` output cannot see that branch's
content, so Nix changes there are checked with `nix-instantiate --parse` plus
statix/deadnix/nixfmt. A full build check needs the cross-branch wiring to exist first.

## Layout gotchas

Applies on every line.

- Raw dotfile dirs live at repo root (`kitty/`, `neovim/`, `niri/`, `tmux/`, `ranger/`,
  `hyprland/`, ...) with chezmoi-style `dot_config/...` names. home-manager deploys them via
  `xdg.configFile."x".source = ../../../<dir>/dot_config/...` in `home/common/optional/*.nix`.
  Deleting or renaming those dirs breaks the build on `nixos` — see Branches.
- On `nixos`, `README.md` is partly stale: it says to edit `userName`/`hostName` at the top of
  `flake.nix`. The real values live in `hosts/hosts.nix` (`diskDevice`,
  `users.<name>.{home,passwordFile}`); `hostName`/`userName` are derived in `flake.nix` from the
  `"<user>@<host>"` configuration keys and passed in through `specialArgs`. Trust code over docs.
- Only `ranger/dot_config/ranger/plugins/ranger_devicon` is a real git submodule (owned by
  `nixos`). `.gitmodules` still lists removed zsh/powerlevel10k entries (prompt moved to
  starship) — stale, ignore.
- `.stylua.toml` (2-space, 120 cols) applies to Lua under `neovim/` (owned by `neovim`).

## Flake outputs

`nixos` only — `master` has a single `nixosConfigurations.nixos`, no VM and no
`modules/validation.nix`.

| Output | Meaning |
|---|---|
| `nixosConfigurations."administrator@nixos"` | single-user deploy of host `nixos` |
| `nixosConfigurations.nixos` | whole host (all users) |
| `nixosConfigurations.nixos-vm` | standalone QEMU test VM |

- Only the two non-VM configs import `disko`, `lanzaboote`, `sops-nix` and
  `modules/{options,validation,sops}.nix`.
- `specialArgs` differ: host configs get `inputs profiles hostName users diskDevice`;
  the VM gets only `inputs profiles hostName`. Never reference `users`/`diskDevice`
  in modules that `hosts/nixos-vm` imports.
- **`hosts/nixos-vm` must stay standalone**: importing `hosts/nixos` hardware (disko,
  tmpfs root, LUKS) collides with build-vm's `mkVMOverride` on `fileSystems` and bricks boot
  ("Failed to start Switch Root"). VM user login is `administrator` / `test`.
- home-manager `extraSpecialArgs` are set in `flake.nix`: `hostName`, `profiles`, plus `userName`
  in the per-user block.

## Secrets

Applies on every line.

- Repo builds with no `secrets/` at all: the flake falls back to empty profiles when
  `builtins.pathExists ./secrets/default.nix` is false, and `modules/sops.nix` is gated with
  `lib.mkIf hasSecrets`. The real `secrets/` tree is `nixos`-owned and never committed;
  `secrets.samples/` is the tracked template.

## Commands

```bash
statix check .      # lint (exit 0 expected)
deadnix .           # unused bindings (exit 0 expected)
nixfmt <nix files you touched>
stylua <lua files you touched>
git diff HEAD       # review before commit
```

Required order before every commit: **statix -> deadnix -> nixfmt -> stylua -> git diff HEAD -> commit**.

### Every line

- When adding/changing software, verify the attribute against the flake's **pinned** nixpkgs,
  not the registry: `nix eval --raw .#nixosConfigurations.<config>.pkgs.<pkg>.pname` (or
  `.version`; `.pkgs.path` prints the pinned nixpkgs source; that `pkgs` is the pinned nixpkgs
  plus the NUR overlay). `<config>` is `nixos-vm` or `nixos` on `nixos`, `nixos` on `master`.
  The registry `nixpkgs#...` can be far ahead (dms-shell: registry 1.6.2 vs pinned 1.4.6) and
  already caused a real incompatibility. For discovery by keyword: `nix search nixpkgs <regex>`
  (e.g. `nix search nixpkgs remmina`; needs network and is slow — it enumerates legacyPackages.
  Note `nix search nixpkgs#<term>` errors: a regex arg is mandatory). Package names are often
  non-obvious (`apostrophe`, `freerdp` -> binary `xfreerdp3`, `kdePackages.*`).
- Fixed-output derivations (`fetchFromGitHub`): leave a fake hash, run the build, copy the `got:`
  hash from the error. For plain `.nix` files use `nix-build <file>` (`nix build` requires a flake
  path). `postFetch` globs in a FOD are unreliable — lift monorepo subdirs with a `runCommand`
  that copies the subdir to the root (example: `hosts/common/optional/dms.nix` on `nixos`).
- No CI, no task runner, no test suite — lint + eval is the whole verification story.

### `nixos` only

- Eval targets — pick by what you touched:
  - `nix eval .#nixosConfigurations.nixos-vm.config.system.build.vm.drvPath` for the VM. It does
    **not** import `modules/{options,validation,sops}.nix`, so it cannot catch errors there. Use
    `system.build.vm`, **not** `toplevel`: the VM declares no root filesystem (by design), which
    trips nixpkgs' "fileSystems does not specify your root file system" assertion.
  - `nix eval .#nixosConfigurations.nixos.config.assertions --apply 'xs: builtins.all (x: x.assertion) xs'`
    for the host path, including `modules/validation.nix` assertions.
- Tools ship with the config: `statix`/`nixfmt`/`deadnix` in
  `hosts/common/packages/system/nixos.nix`, `stylua` in `hosts/common/packages/dev/lua.nix`. On
  non-NixOS: `nix profile install nixpkgs#statix nixpkgs#deadnix nixpkgs#nixfmt` (binaries in
  `~/.nix-profile/bin`; `statix` has no `--version`, use `statix --help`).
- DMS plugins (`hosts/common/optional/dms.nix`): keep the pinned `rev` compatible with both the
  plugin's `requires_dms` and the pinned dms-shell version (check the latter with
  `nix eval --raw .#nixosConfigurations.nixos-vm.pkgs.dms-shell.version`), and re-audit the plugin
  source on every bump. After a rev bump verify the *content* that landed on the host, not just
  that the path exists — a stale install shows up as `"<Type> is not a type"` QML errors: check
  `grep '"version"' /etc/xdg/quickshell/dms-plugins/DankKDEConnect/plugin.json` and
  `journalctl --user -u dms -b | grep -iE 'component error|dankKDE'`, then `dms restart` (or
  `systemctl --user restart dms`) and re-enable the plugin in the UI.
- VM build test: `nh os build-vm .#nixos-vm` (or `nixos-rebuild build-vm --flake .#nixos-vm`).

## Neovim / LSP

`neovim` only.

- Language servers come from `hosts/common/packages/dev/lsp.nix`; per-server commands live in
  `neovim/dot_config/nvim/lua/lsp/<server>.lua`. Never add a mason-installed server.
- `vscode-langservers-extracted` and `yaml-language-server` need an explicit `--stdio`; without it
  the server starts, throws "Connection input stream is not set" and exits 1, so Neovim reports no
  active client.
- `:checkhealth vim.lsp` only proves a client was created. Verify with a real request
  (`vim.lsp.buf_request`) or the editing feature you actually need, and read
  `~/.local/state/nvim/lsp.log` for server stderr.
- Neovim plugin versions are intentionally unlocked — do not generate `lazy-lock.json`.

## Conventions

Applies on every line, except the three bullets marked `nixos` below.

- Comments/messages in **English only**. Conventional commits
  (`feat(scope):`, `fix(...)`, `style:`), scope = affected dir (`packages`, `nixos-vm`, ...).
- Every comment must earn its place in the *final* file: after each edit, re-read the
  surrounding block and delete comments that restate the code, explain an entry you just
  removed, or duplicate the schema/other docs. Keep only non-obvious *why* (upstream quirks,
  deliberate deviations, footguns) — and put that "why" where the deviation lives, not next
  to a list it no longer belongs to.
- statix rules the style: merge repeated attr keys into one nested attrset
  (`boot.a`/`boot.b` -> `boot = { a; b; }`), empty module pattern `{ ... }:` -> `_:`,
  `x = x;` -> `inherit x;`. deadnix: drop unused lambda args or prefix `_`
  (`mapAttrs (_: _: ...)`).
- `nixos`: `modules/options.nix` and `modules/validation.nix` are coupled: validation checks
  hand-written `valid*Fields` string lists, not the option definitions. Adding,
  renaming or removing an option in `options.nix` means updating the matching
  whitelist in `validation.nix` **in the same commit**, otherwise a valid profile
  field is rejected by the "Unknown fields" assertion. Mapping: `sshHostSubmodule`
  -> `validSshHostFields`, `singBoxSubmodule` -> `validSingBoxFields`,
  `wireguardSubmodule` -> `validWireguardFields`, `git`/`ssh` under
  `userProfileSubmodule` -> `validGitFields`/`validSshFields`, `hostProfileSubmodule`
  -> `validHostFields`. The assertion is skipped when `profiles` is empty (no
  `secrets/`), so exercise it with a real `profiles.nix`.
- `nixos`: Nix tooling (statix, nixfmt, deadnix) belongs only in
  `hosts/common/packages/system/nixos.nix` — don't split it out.
- `nixos`: packages are grouped by use case under `hosts/common/packages/*/`; duplicates across
  groups are intentional (independent toggling).
- Don't add packages the user didn't ask for.
- Repo is fully nixfmt-formatted — only format files you touched, never bulk-reformat.
